require 'spec_helper'

feature 'Bookmark', :signin do
  let(:topic) { create(:topic) }
  before(:each) { visit topic_path(topic) }

  scenario 'User bookmarks a topic successfully' do
    click_link 'js-bookmark'
    expect(@user.bookmarks).to eq [topic.id]
  end
end
