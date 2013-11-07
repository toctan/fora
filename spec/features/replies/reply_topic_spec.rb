require 'spec_helper'

feature 'Reply a topic', :signin do
  let(:topic) { create(:topic) }
  let(:reply) { attributes_for(:reply) }

  before(:each) do
    visit topic_path(topic)
  end

  scenario 'with simple body' do
    fill_in 'reply_body', with: reply[:body]
    click_button 'Create Reply'

    within '.replies' do
      expect(page).to have_selector('.reply-item:last-child', text: reply[:body])
    end
  end

  scenario 'with blank body' do
    click_button 'Create Reply'

    expect(page).to have_flash_message("can't be blank", 'error')
  end
end
