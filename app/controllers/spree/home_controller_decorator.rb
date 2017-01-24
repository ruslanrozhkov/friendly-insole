Spree::HomeController.class_eval do
  include MessageHelper

  helper_method :sort_by, :order_by_icon

  def set_default_search
    params[:order_by] = 'completed_at' if params[:order_by].blank?
    params[:direction] = 'desc' if params[:direction].blank?
  end

  def sort_by(column)
    params.merge(order_by: column, direction: params[:direction] == 'desc' ? :asc : :desc)
  end

  def order_by_icon(column)
    set_default_search

    if params[:order_by].to_sym == column
      icon = params[:direction] == 'asc' ? 'glyphicon-triangle-bottom' : 'glyphicon-triangle-top'

      "<i class='small glyphicon #{icon}'></i>".html_safe
    end
  end

  def index
    unless @is_manufacturer
      get_client_dashboard_data
    else
      get_manufacturer_dashboard_data
    end

    @messages = []

    #@messages = Message.where(user: spree_current_user, ).order(:created_at => "DESC")
    # Spree::Order.where(user: spree_current_user).each do |order|
    #   order.messages.each do |message|
    #     @messages << message if message.user != spree_current_user and !has_read(spree_current_user, message)
    #   end
    # end

    Message.where.not(user: spree_current_user).order(:created_at => "DESC").each do |message|
      if message.intended_for
        if @is_admin
          # HQ (admin) can view all new messages from their orders on frontend
          @messages << message if !has_read(spree_current_user, message) and message.order.user == spree_current_user and message.intended_for.name == 'admin'
        elsif @is_manufacturer
          # Manufacturer can view all new messages from all approved orders
          @messages << message if !has_read(spree_current_user, message) and message.order.approved? and message.intended_for.name == 'manufacturer'
        else
          # User can view all new messages from only their orders
          @messages << message if !has_read(spree_current_user, message) and message.order.user == spree_current_user and message.intended_for.name == 'user'
        end
      end
    end
  end

  # Logic for user's dashboard view
  def get_client_dashboard_data
    set_default_search

    all_orders = spree_current_user.orders.complete

    params[:q] = {} unless params[:q]

    if params[:q][:completed_at_gt].blank?
      params[:q][:completed_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:completed_at_gt] = Time.zone.parse(params[:q][:completed_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:completed_at_lt].blank?
      params[:q][:completed_at_lt] = Time.zone.parse(params[:q][:completed_at_lt]).end_of_day rescue ""
    end

    @search = spree_current_user.orders.complete.order("#{params[:order_by]} #{params[:direction]}").ransack(params[:q])
    @orders = @search.result

    # Now filter the statuses
    if !params[:status].blank?
      @orders = @orders.select { |o|
        o.generate_status == params[:status]
      }.map{ |o|
        o
      }
    end

    # filter the search down further if we receive a patient id to search for
    unless params[:patient_id].blank?
      @orders = @orders.select { |o|
        x = o.line_items.select{ |li|
          li.order_form.patient_id.include?(params[:patient_id])
        }
        true unless x.empty?
      }.map { |o|
        o
      }
    end

    @has_orders = !all_orders.blank?
  end

  # Logic for manufacturers dashboard view
  def get_manufacturer_dashboard_data
    # Set the default time selected in the drop down
    params[:time] = 'last 30 days' if params[:time].blank?

    @times = [
        {'label' => 'all', 'val' => Time.at(0)},
        {'label' => 'last year', 'val' => 1.year.ago},
        {'label' => 'last 6 months', 'val' => 6.months.ago},
        {'label' => 'last 3 months', 'val' => 3.months.ago},
        {'label' => 'last 30 days', 'val' => 30.days.ago},
        {'label' => 'last 7 days', 'val' => 7.days.ago}
    ]

    selected_time = @times.detect {|t| t['label'] == params[:time]}

    base_search = Spree::Order.joins(:status)
                      .where('approved_at >= ?', selected_time['val'])
                      .where('number like ?', "%#{params[:search]}%")

    @inbound_orders = base_search.where(:approver_id => !nil)
                          .where('canceler_id IS NULL OR state = "resumed"')
                          .where(:statuses => {:current => 'inbound'})

    @in_progress_orders = base_search.where(:statuses => {:current => 'in production'})

    @shipped_orders = base_search.where(:statuses => {:current => 'shipped'})
  end

end