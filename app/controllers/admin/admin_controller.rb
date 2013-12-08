class Admin::AdminController < ApplicationController
  before_filter :ensure_admin

  private

  def ensure_admin
    require_login
    redirect_to root_path, alert: I18n.t('access_denied') unless current_user.admin?
  end
end
