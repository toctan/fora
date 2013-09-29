class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?
  before_filter :can_can_can

  def can_can_can
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password) }

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :avatar, :email, :password, :password_confirmation, :current_password)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
