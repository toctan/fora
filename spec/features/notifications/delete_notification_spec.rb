require 'spec_helper'

feature 'Signed in user' do
  let(:user) { create(:confirmed_user) }

  before do
    create_list(:notification_mention, 3, user: user)
    login_as user, scope: :user
    visit notifications_path
  end

  scenario 'deletes single notification' do
    pending
    expect {
      within '#notifications' do
        first('.notification-item').click_link 'Delete'
      end
    }.to change(Notification::Base, :count).by(-1)
  end

  scenario 'deletes all the notifications' do
    pending
    expect {
      within '#notifications' do
        click_link 'Clear'
      end
    }.to change(Notification::Base, :count).to(0)
  end
end
