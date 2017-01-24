class MessagesController < ApplicationController
  load_and_authorize_resource # automatically instill authorization of all REST actions

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    head :forbidden # as to land in the error block of the AJAX call
  end

  def create
    params.require(:body)
    params.require(:order_number)
    params.require(:intended_for)

    @message = Message.create!({
      body: params[:body],
      order: Spree::Order.find_by_number(params[:order_number]),
      user: spree_current_user,
      intended_for: Spree::Role.find_by_name(params[:intended_for])
    })

    # MessageHistory.create!({message: @message, user: spree_current_user, read: true})

    redirect_to params[:from_url]
  end

  def update
    # @message is generated from the load_and_authorize_resource helper

    params.require(:message).permit(:read)
    read_state = params[:message][:read]

    # @message.update_attributes!(params[:message].to_hash)

    if read_state.present?
      @message.set_read_state(spree_current_user, read_state)
    end

    render json: @message.reload
  end

end
