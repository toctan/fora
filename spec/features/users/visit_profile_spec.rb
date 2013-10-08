require 'spec_helper'

feature 'User profile page' do
  let(:user) { create(:confirmed_user) }
  before do
    create_list(:topic, 30, user: user)
    create_list(:reply, 25, user: user)

    visit user_path(user.username)
  end

  scenario "Visitor sees all the user's topics and repies" do
    expect(page).to have_content(user.username)
    expect(page).to have_selector('#self-topics tr', count: 31)
    expect(page).to have_selector('#self-replies tr', count: 50)
  end
end
