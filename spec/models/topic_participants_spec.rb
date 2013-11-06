require 'spec_helper'

describe TopicParticipants do
  describe '#participants' do
    subject(:tp) { TopicParticipants.new(topic, users: users) }
    let(:users) { users_fetcher(topic.participant_ids) }
    let(:participants) { tp.participants }

    context 'when there is no reply' do
      let(:topic) { double(participant_ids: [1, nil]) }

      it 'returns the author as the only participant' do
        desc = participants[0].description.join(', ')

        expect(participants.length).to eq 1
        expect(desc).to eq I18n.t(:topic_author)
      end
    end

    context 'when there is no active repliers' do
      let(:topic) { double(participant_ids: [1, 3]) }

      it 'returns the author and the last replier with desc' do
        expect(participants.length).to eq 2

        last_replier_desc = participants.last.description.join(', ')
        expect(last_replier_desc).to eq I18n.t(:last_replier)
      end
    end

    context 'when there are 4 active repliers' do
      let(:topic) { double(participant_ids: [1, 6, 2, 3, 4, 5]) }

      it 'returns at most 5 participants' do
        expect(participants.length).to eq 5

        most_replies_desc = participants[1].description.join(', ')
        expect(most_replies_desc).to eq I18n.t(:most_replies)
      end
    end

    context 'when the last replier is also active' do
      let(:topic) { double(participant_ids: [1, 6, 2, 3, 6, 5]) }

      it 'set the last repliers desc properly' do
        expect(participants.length).to eq 5

        last_replier_desc = participants.last.description.join(', ')
        expect(last_replier_desc).to eq "#{I18n.t(:last_replier)}, #{I18n.t(:active_replier)}"
      end
    end
  end
end

def users_fetcher(ids)
  Hash.new.tap do |hash|
    ids.each do |id|
      hash[id] = build(:user).tap { |u| u.id = id } if id
    end
  end
end
