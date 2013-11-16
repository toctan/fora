require 'spec_helper'

feature 'Receive notification when', :signin do
  let(:topic) { create(:topic, user: @current_user) }

  scenario 'someone replies my topic' do
    create(:reply, topic: topic)

    visit root_path

    expect(page).to have_selector('//a[@class="notifier"][@data-count="1"]')
  end

  scenario 'mentioned in reply' do
    reply = create(:reply, body: "@#{@current_user.username}")

    visit notifications_path

    expect(page).to have_content reply.body
  end

  scenario 'mentioned in topic' do
    topic = create(:topic, body: "@#{@current_user.username}")

    visit notifications_path

    expect(page).to have_link topic.title
  end
end
