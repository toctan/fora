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

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def clear
    current_user.clear_notifications

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end
