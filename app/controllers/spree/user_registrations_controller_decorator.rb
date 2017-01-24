Spree::UserRegistrationsController.class_eval do
  after_filter :set_default_user_role, only: :create

  def set_default_user_role
    @user.spree_roles << Spree::Role.find_by_name('user')
  end

end