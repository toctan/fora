class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = current_user.notifications
    current_user.read_notifications
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy if @notification
    redirect_to notifications_url
  end

  def clear
    current_user.clear_notifications
    redirect_to notifications_url
  end
end
