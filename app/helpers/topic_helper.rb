module TopicHelper
  def star?
    current_user.stars.include?(params[:id].to_i)
  end
end
