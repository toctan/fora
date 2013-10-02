require 'spec_helper'

feature 'Receive notification when' do
  let(:user)  { create(:confirmed_user) }
  let(:topic) { create(:topic, user: user) }

  before { login_as user, scope: :user }

  after(:each) do
    visit root_path

    expect(page).to have_selector('.notification-indicator')
  end

  scenario 'someone replies my topic' do
    create(:reply, topic: topic)
  end

  scenario 'mentioned in reply' do
    create(:reply, body: "@#{user.username}")
  end

  scenario 'mentioned in topic' do
    create(:topic, body: "@#{user.username}")
  end
end
