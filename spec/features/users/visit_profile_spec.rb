require 'spec_helper'

feature 'visit user profile' do
  let(:user) { create(:confirmed_user) }
  before do
    create_list(:topic, 30, user: user)
    create_list(:reply, 5, user: user)

    visit user_path(user.username)
  end

  scenario 'by unsigned user' do

    expect(page).to have_content(user.username)
  end

  scenario 'which has too many topics' do
    expect(page).to have_link("More topics")
    expect(page).to have_selector(".topic-item", count: 10)
  end

  scenario 'which has some replies' do
    expect(page).not_to have_link("More replies")
    expect(page).to have_selector(".reply-item", count:   5)
  end
end