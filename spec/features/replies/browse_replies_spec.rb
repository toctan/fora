require 'spec_helper'

feature 'Browse replies' do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  scenario 'Browse replies for a topic' do
    create_list(:reply, 25, user: user, topic: topic)

    visit topic_path(topic)

    within '#replies' do
      expect(page).to have_selector('.reply-item', count: 20)
    end
    expect(page).to have_selector('div.pagination')
  end
end