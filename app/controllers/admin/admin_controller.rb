class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_admin

  private

  def ensure_admin
    fail CanCan::AccessDenied unless current_user.admin?
  end
end
