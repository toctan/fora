class RepliesController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def create
    @topic = Topic.find(params[:topic_id])
    @reply = @topic.replies.build(reply_params)
    @reply.user_id = current_user.id

    flash[:notice] = "Reply body can't be blank" unless @reply.save
    redirect_to :back
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end
end
