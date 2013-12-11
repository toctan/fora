class SessionsController < ApplicationController
  def create
    user = User.from_omniauth auth_hash
    if user.save
      self.current_user = user
      redirect_to auth_origin || root_url
    else
      session[:omniauth] = auth_hash
      redirect_to new_user_path
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_url, notice: I18n.t('signed_out')
  end

  def failure
    redirect_to root_url, alert: params[:message]
  end

  private

  def auth_hash
    request.env['omniauth.auth'].except('extra').tap do |auth|
      auth.uid = auth.uid.to_s
    end
  end

  def auth_origin
    request.env['omniauth.origin']
  end
end
