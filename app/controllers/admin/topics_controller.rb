class Admin::TopicsController < Admin::AdminController
  include TopicsConcern

  def destroy
    redirect_to root_url, notice: 'Delete topic successfully' if @topic.destroy
  end
end
