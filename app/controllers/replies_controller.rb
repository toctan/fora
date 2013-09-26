class RepliesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.build(reply_params)
    @reply.user_id = current_user.id

    redirect_to :back if @reply.save
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end
end
