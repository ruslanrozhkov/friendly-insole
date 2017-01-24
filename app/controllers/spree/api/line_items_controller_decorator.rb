Spree::Api::LineItemsController.class_eval do

  before_filter :update_order_form, :only => :update

  def update_order_form
    line_item = find_line_item

    ActionController::Parameters.permit_all_parameters = true

    # Data is received as multipart form data
    options = JSON.parse(params[:line_item][:options])

    # Strip out the propertied that matter and replace their keys with proper names
    # that the model is used to seeing, i.e. get rid of [ ]
    hashed_options = options.collect{|k,v| ["#{k.match(/(?<=\[).+?(?=\])/)}", v]}.to_h

    # Remove the blank property which was the auth token
    hashed_options.reject!{ |k| k.blank? }

    # Add into the hash the stl and csv file if any
    hashed_options['stl_file_l'] = params[:line_item][:stl_file_l] == 'undefined' ? line_item.order_form.stl_file_l : params[:line_item][:stl_file_l]
    hashed_options['stl_file_r'] = params[:line_item][:stl_file_r] == 'undefined' ? line_item.order_form.stl_file_r : params[:line_item][:stl_file_r]
    hashed_options['csv_file'] = params[:line_item][:csv_file] == 'undefined' ? line_item.order_form.csv_file : params[:line_item][:csv_file]

    # Find the form we need to update
    order_form = OrderForm.find_by_line_item_id(line_item.id)

    # Validate the order form first
    order_form_to_validate = OrderForm.new(hashed_options)
    if !order_form_to_validate.valid?
      flash[:error] = order_form_to_validate.errors.to_a
      render json: {location: cart_admin_order_path(line_item.order)}
    end

    # Only save the form if validation passes
    order_form.update_attributes(hashed_options)
  end

end