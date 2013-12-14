class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    if cookies[:remember_token]
      @current_user ||= User.find_by remember_token: cookies[:remember_token]
    end

    @current_user
  end
  helper_method :current_user

  def current_user=(user)
    @current_user = user
    session[:omniauth] = nil
    cookies.permanent[:remember_token] = user && user.remember_token
  end

  def require_login
    redirect_to root_url, alert: I18n.t('need_sign_in') unless current_user
  end
end
