require 'spec_helper'

feature 'Likes', :signin do
  let(:user) { @current_user }
  let(:topic) { create(:topic, user: user) }

  before { visit topic_path(topic) }

  scenario 'A user likes a topic' do
    click_link 'js-like'

    expect(page).to have_content '1 Likes'
  end

  context 'When user has liked the topic' do
    let(:topic) { create(:topic, user: user).tap { |t| user.like t } }

    scenario 'A user dislikes a topic' do
      click_link 'js-like'

      expect(page).to have_content '0 Likes'
    end
  end
end
