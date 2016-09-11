class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_filter :blocked?
  hide_action :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(
        :email, :password, :password_confirmation,
        :username, :image, :blocked
      )
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      root_path
    when :admin, Admin
      flags_path
    else
      super
    end
  end

  def blocked?
    if current_user.present? && current_user.blocked?
      sign_out current_user
      flash[:notice] = 'This account has been suspended....'
      root_path
    end
  end
end
