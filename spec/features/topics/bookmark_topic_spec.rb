require 'spec_helper'

feature 'Bookmark', :signin do
  let(:topic) { create(:topic) }

  scenario 'User bookmarks a topic successfully', :js do
    visit topic_path(topic)
    click_link 'js-bookmark'

    wait_for_ajax

    visit bookmarks_path

    expect(page).to have_content(topic.title)
  end
end

def wait_for_ajax
  Timeout.timeout(Capybara.default_wait_time) do
    loop do
      active = page.evaluate_script('jQuery.active')
      break if active == 0
    end
  end
end
