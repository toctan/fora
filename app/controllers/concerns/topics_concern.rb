module TopicsConcern
  extend ActiveSupport::Concern

  included do
    before_filter :find_topic,  only: [:show, :destroy]
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end
end
