Spree::OrdersController.class_eval do
  # Should also skip this before action for only specific actions, but there is a Rails
  # bug that only considers either the :if or the :only
  skip_before_action :check_authorization, :if => proc {@is_manufacturer}

  before_action :get_saved_line_items, only: :edit
  before_action :validate_order_form, only: :populate

  def cancel
    order_number = params[:id]
    order = Spree::Order.where(:number => order_number)
                .where(:user_id => spree_current_user.id)
                .where(:canceler_id => nil)
                .where(:approver_id => nil)
                .first

    if order.present?
      # Cancel the order if we found it
      order.canceled_by(try_spree_current_user)
      flash[:success] = 'Order ' + order_number + ' successfully canceled.'
    else
      flash[:danger] = 'Order ' + order_number + ' has already been canceled, you cannot cancel this order anymore.'
    end

    render json: order
  end

  def change_status(order_number = params[:id], status = params[:status])
    order = Spree::Order.find_by number: order_number

    authorize! :change_status, order

    if order.status.change_status(status)
      if status == 'shipped'
        Message.create!({
            body: 'This order is en route to HQ',
            order: order,
            user: spree_current_user,
            intended_for: Spree::Role.find_by_name('admin')
        })
      end

      flash[:success] = 'Order ' + order_number + ' moved to ' + status + '.'
    else
      flash[:danger] = 'Unable to set order ' + order_number + ' to ' + status + '.'
    end

    render json: order
  end

  def change_manufacturer_tracking_number(order_number = params[:id], tracking = params[:tracking])
    order = Spree::Order.find_by number: order_number

    if ManufacturerShipment.change_tracking(order, tracking)
      flash[:success] = 'Tracking updated for ' + order_number + '.'
    else
      flash[:danger] = 'Unable to set tracking number for ' + order_number + '.'
    end

    render json: order
  end

  def duplicate_order(order_number = params[:id])
    order = current_order(create_order_if_necessary: true)

    order_to_duplicate = Spree::Order.find_by number: order_number

    order_to_duplicate.line_items.each do |item|
      order_form = item.order_form

      variant  = item.variant
      quantity = item.quantity
      options  = item.order_form.attributes

      line_item = order.contents.add(variant, quantity, options)

      line_item.order_form.stl_file_l = order_form.stl_file_l
      line_item.order_form.stl_file_r = order_form.stl_file_r
      line_item.order_form.csv_file = order_form.csv_file

      line_item.order_form.save!
    end

    render json: order.reload
  end

  def duplicate_item(item_id = params[:id])
    order = current_order(create_order_if_necessary: true)

    item_to_duplicate = Spree::LineItem.find_by_id(item_id)
    order_form_to_duplicate = item_to_duplicate.order_form

    variant  = item_to_duplicate.variant
    quantity = item_to_duplicate.quantity
    options  = order_form_to_duplicate.attributes

    line_item = order.contents.add(variant, quantity, options)

    line_item.order_form.stl_file_l = order_form_to_duplicate.stl_file_l
    line_item.order_form.stl_file_r = order_form_to_duplicate.stl_file_r
    line_item.order_form.csv_file = order_form_to_duplicate.csv_file

    line_item.order_form.save!

    render json: order.reload
  end

  def validate_order_form
    # Redirect back to product in the event we have a validation error
    # and the JS validation misses it.
    params.require(:options).permit!
    order_form = OrderForm.new(params[:options])

    if !order_form.valid?
      flash[:danger] = order_form.errors.to_json
      redirect_to product_path(Spree::Product.last)
    end
  end

  def save_for_later(item_id = params[:id])
    line_item = Spree::LineItem.find_by_id(item_id)

    # Make sure that the line item being added actually belongs to this user
    if line_item.order.user == spree_current_user
      # Save the line item
      item_to_save_for_later = SavedLineItem.create!({
          user: spree_current_user,
          variant: line_item.variant,
          quantity: line_item.quantity
                                                    })

      options = line_item.order_form.attributes.except('id')

      # Now save the form
      form = OrderForm.new(options)
      form.line_item = nil
      form.saved_line_item = item_to_save_for_later
      form.stl_file_l = line_item.order_form.stl_file_l
      form.stl_file_r = line_item.order_form.stl_file_r
      form.csv_file = line_item.order_form.csv_file
      form.save!(validate: false)

      # Remove the line item from the cart
      order = current_order
      order.line_items.destroy(line_item)

      refresh_order(order)

      render json: order.reload
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def move_to_cart(item_id = params[:id])
    order = current_order(create_order_if_necessary: true)
    saved_line_item = SavedLineItem.find_by_id(item_id)

    if saved_line_item.user == spree_current_user
      order_form_to_duplicate = saved_line_item.order_form

      variant  = saved_line_item.variant
      quantity = saved_line_item.quantity
      options  = order_form_to_duplicate.attributes

      line_item = order.contents.add(variant, quantity, options)

      line_item.order_form.stl_file_l = order_form_to_duplicate.stl_file_l
      line_item.order_form.stl_file_r = order_form_to_duplicate.stl_file_r
      line_item.order_form.csv_file = order_form_to_duplicate.csv_file

      line_item.order_form.save!(validate: false)

      # Now we need to delete the old order_form and the saved_line_item
      # Deleting the saved line item will delete the associated form
      saved_line_item.destroy!

      render json: line_item.reload
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def get_saved_line_items
    @saved_line_items = SavedLineItem.where(user: spree_current_user)
  end

  private
    def refresh_order(order)
      persist_totals(order)
      Spree::PromotionHandler::Cart.new(order).activate
      order.ensure_updated_shipments
      persist_totals(order)
    end

    def persist_totals(order)
      @order_updater = Spree::OrderUpdater.new(order)
      @order_updater.update_item_count
      @order_updater.update
    end
end