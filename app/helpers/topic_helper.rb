module TopicHelper
  def stared?
    current_user.stars.include?(params[:id].to_i)
  end
end
