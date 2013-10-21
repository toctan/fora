require 'spec_helper'

feature 'Admin' do
  let(:topic) { create(:topic) }

  before(:each) do
    login_as create(:admin), scope: :user
    visit topic_path(topic)
  end

  scenario 'deletes a topic' do
    pending
    expect { click_link 'delete' }.to change(Topic, :count).by(-1)

    expect(page).to have_flash_message 'Delete topic successfully'
  end
end
