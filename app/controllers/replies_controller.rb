class RepliesController < ApplicationController
  before_filter :require_login
  before_filter :find_topic

  def index
    @replies = @topic.replies.where('id > ?', params[:since_id].to_i)
  end

  def create
    reply = @topic.new_reply(current_user, reply_params)
    flash[:alert] = reply.errors.full_messages.join("\n") unless reply.valid?

    respond_to do |format|
      format.html { redirect_to @topic }
      format.js
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:body)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
