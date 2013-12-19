require 'spec_helper'

feature 'Likes', :signin do
  let(:user) { @current_user }
  let(:topic) { create(:topic, user: user) }

  scenario 'A user likes a topic', :js do
    visit topic_path(topic)

    find('.js-like').click

    expect(page).to have_selector '.js-likes-count[data-count="1"]'
  end

  context 'When user has liked the topic' do
    before(:each) do
      user.likes.create(likeable: topic)
    end

    scenario 'A user dislikes a topic', :js do
      visit topic_path(topic)

      find('.js-like').click

      expect(page).to have_selector '.js-likes-count[data-count="0"]'
    end
  end
end
