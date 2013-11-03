require 'spec_helper'

feature 'Delete topic' do
  let(:topic) { create(:topic) }

  before(:each) do
    login_as create(:admin), scope: :user
    visit topic_path(topic)
  end

  scenario 'deletes a topic' do
    expect { click_link 'js-delete-topic' }.to change(Topic, :count).by(-1)

    expect(page).to have_flash_message 'Delete topic successfully'
  end
end
