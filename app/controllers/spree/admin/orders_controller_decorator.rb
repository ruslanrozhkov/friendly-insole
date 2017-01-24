Spree::Admin::OrdersController.class_eval do
  include MessageHelper

  before_action :approve_for_manufacturer, :only => :approve
  before_action :get_messages, :only => :index

  def approve_for_manufacturer
    # @order.status.update_columns(
    #     current: 'inbound'
    # )

    Status.create({order: @order, current:'inbound'})
  end

  def get_messages
    @messages = []

    Message.where.not(user: spree_current_user).order(:created_at => "DESC").each do |message|
      @messages << message if !has_read(spree_current_user, message)
    end
  end

end