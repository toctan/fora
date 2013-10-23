require 'spec_helper'

feature 'Homepage' do
  before(:all) do
    create(:user) do |user|
      create_list(:topic, 21, user: user)
    end
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  before(:each) { visit root_path }

  scenario 'Visitor browses topics' do
    within '#topics' do
      expect(page).to have_selector('.topic-item', count: 20)
    end
  end

  scenario 'Visitor visits homepage' do
    pending
    expect(page).to have_selector('#user-links .icon-signin')
    expect(page).to have_link('sign up', href: new_user_registration_path)
  end

  scenario 'Signed in user visits homepage', :signin do
    pending
    expect(page).to have_selector('#user-links .icon-signout')
    expect(page).not_to have_selector('#user-links .icon-signin')
  end
end
