class RepliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_topic

  def create
    reply = @topic.new_reply(current_user, reply_params)
    flash[:error] = reply.errors.full_messages.join("\n") unless reply.valid?

    redirect_to :back
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
