class OmniauthCallbacksController < ApplicationController

  def all
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: user.provider
      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :weibo,   :all
end
