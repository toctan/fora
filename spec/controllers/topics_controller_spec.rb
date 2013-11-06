require 'spec_helper'

describe TopicsController do
  describe 'GET show' do
    let(:topic) { Topic.new }
    it 'redirects the topic hits' do
      allow(Topic).to receive(:find).and_return(topic)
      expect(topic).to receive(:update_hits)

      get :show, id: 1
    end
  end
end
