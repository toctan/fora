require 'spec_helper'

feature 'Delete topic' do
  let(:topic) { create(:topic) }

  scenario 'Admin deletes a topic', :admin do
    visit topic_path(topic)

    expect { click_link 'js-delete-topic' }.to change(Topic, :count).by(-1)

    expect(page).to have_flash_message 'Delete topic successfully'
  end
end
