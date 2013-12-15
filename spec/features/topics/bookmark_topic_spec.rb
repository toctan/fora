require 'spec_helper'

feature 'Bookmark', :signin do
  let(:topic) { create(:topic) }

  scenario 'User bookmarks a topic successfully', :js do
    # TODO: This test fails randomly, why?
    visit topic_path(topic)
    click_link 'js-bookmark'

    visit bookmarks_path

    expect(page).to have_content(topic.title)
  end
end
