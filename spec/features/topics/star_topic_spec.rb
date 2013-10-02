require 'spec_helper'

feature 'Star topic', :signin do
  let(:topic) { create(:topic) }

  scenario 'Signed in user stars a topic' do
    visit topic_path(topic)

    click_link 'star'
    expect(page).to have_selector('i.icon-star')

    click_link 'unstar'
    expect(page).to have_selector('i.icon-star-empty')
  end
end
