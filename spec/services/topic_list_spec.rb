require 'spec_helper'

describe TopicList do
  describe '.list' do
    it 'returns a list of topic with its posters' do
      topic = double(participant_ids: [1, nil, nil], participants: "")
      allow(Topic).to receive(:page) { [topic] }

      expect(UsersFetcher).to receive(:new).with([[1, nil, nil]])
      expect(topic).to receive(:participants)

      TopicList.list 1
    end
  end
end
