class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def require_login
    redirect_to root_url, alert: I18n.t('need_sign_in') unless current_user
  end

  private

  def can_can_can
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
