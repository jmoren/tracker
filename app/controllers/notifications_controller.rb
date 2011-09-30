class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications  
  end

  def get_notifications
    @notifications = current_user.notifications
    @notifications_count = current_user.notifications.unreaded.size
    @notifications_total_count = current_user.notifications.size
    render 'get_notifications', :layout => false
  end

  def update_notification
    @notification = Notification.find(params[:id])
    @notification.update_attributes(:readed => true)
    @unreaded_count = current_user.notifications.unreaded.size
  end

  def destroy
    notification = Notification.find(params[:id])
    @id = notification.id
    notification.destroy
  end

end
