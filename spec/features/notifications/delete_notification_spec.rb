require 'spec_helper'

feature 'Signed in user', :signin do
  before do
    create_list(:notification, 3, target: @current_user)
    visit notifications_path
  end

  scenario 'deletes single notification' do
    first('.js-delete-notification').click

    expect(page).to have_selector('.notification-item', count: 2)
  end

  scenario 'deletes all the notifications' do
    click_link 'js-clear-notification'

    expect(page).not_to have_selector('.notification-item')
  end
end
