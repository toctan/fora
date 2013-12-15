require 'spec_helper'

feature 'Reply a topic', :signin do
  let(:topic) { create(:topic) }

  before(:each) do
    create(:reply, topic: topic, user: User.first)
    visit topic_path(topic)
  end

  scenario 'with simple body', :js do
    fill_in 'reply_body', with: 'hey'
    click_button 'Create Reply'

    expect(page).to have_selector('.reply', text: 'hey')
    expect(find('#reply_body').value).to eq ''
  end

  scenario 'with blank body' do
    click_button 'Create Reply'

    expect(page).to have_flash_message("can't be blank", 'alert')
  end
end
