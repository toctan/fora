class NotificationsController < ApplicationController
  before_filter :require_login

  def index
    @notifications = current_user.notifications
      .includes(:source, :topic, :reply).page(params[:page])
    current_user.read_notifications
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy if @notification
    redirect_to :back
  end

  def clear
    current_user.clear_notifications
    redirect_to :back
  end
end
