class ApplicationController < ActionController::Base
  # Our theme
  Spree::Config[:layout] = 'application'

  # Default Spree theme (not used, uncomment to see what it looks like)
  #Spree::Config[:layout] = 'spree/layouts/spree_application'

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login, only: :index
  before_filter do
    @is_manufacturer = check_for_manufacturer
    @is_admin = check_for_admin
    @is_user = check_for_user
  end

  # Add the ability to respond to csv's
  ActionController::Renderers.add :csv do |csv, options|
    filename = options[:filename] || 'data'
    send_data csv, disposition: "attachment; filename=#{filename}.csv"
  end

  # Add the ability to respond to pdf's
  ActionController::Renderers.add :pdf do |pdf, options|
    filename = options[:filename] || 'data'
    send_data pdf.render, filename: "#{filename}.pdf", type: 'application/pdf'
  end

  def require_login
    unless spree_current_user
      redirect_to spree_login_path
    end
  end

  def check_for_manufacturer
    spree_current_user.has_spree_role?('manufacturer') if spree_current_user
  end

  def check_for_admin
    spree_current_user.has_spree_role?('admin') if spree_current_user
  end

  def check_for_user
    spree_current_user.has_spree_role?('user') || (!@is_admin && !@is_manufacturer) if spree_current_user
  end

  # Overwrite after sign in handling
  def after_sign_in_path_for(resource)
    if @is_admin
      admin_path
    else
      root_path
    end
  end

  def current_ability
    @current_ability ||= Ability.new(spree_current_user)
  end
end
