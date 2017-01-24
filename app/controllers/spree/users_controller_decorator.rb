Spree::UsersController.class_eval do
  after_filter :flash_notice

  def show
    @addresses = Spree::Address.where(:user_id => spree_current_user.id)

    #@default_bill_address = Spree::Address.default(@user, "bill")
    #@default_ship_address = Spree::Address.default(@user, "ship")
  end

  # lets fix the notice alert to be a success alert
  def flash_notice
    if flash[:notice]
      message = flash[:notice]
      flash.clear
      flash[:success] = message
    end
  end

end