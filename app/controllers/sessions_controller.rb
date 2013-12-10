class SessionsController < ApplicationController
  def create
    user = User.from_omniauth auth_hash
    if user.persisted?
      self.current_user = user
      redirect_to auth_origin || root_url
    else
      # TODO: when third-party sign in fails
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
    request.env['omniauth.auth']
  end

  def auth_origin
    request.env['omniauth.origin']
  end
end
