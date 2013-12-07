require 'spec_helper'

feature 'New topic' do
  let(:node)  { create(:approved_node) }
  let(:topic) { attributes_for(:topic) }

  context 'When user is signed in', :signin do
    before(:each) do
      visit "/new/#{node.key}"
    end

    scenario 'Posts a new topic with blank body' do
      fill_new_topic_form

      expect(page).to have_content topic[:title]
    end

    context 'when the user forgets to fill the title' do
      before { click_button 'Create Topic' }

      scenario 'Fill the missed title' do
        fill_new_topic_form

        expect(page).to have_content topic[:title]
      end
    end
  end

  scenario 'Unsigned user tries to visit new topic page' do
    visit "/new/#{node.key}"

    expect(page).to have_flash_message('You need to sign in', 'alert')
  end
end

def fill_new_topic_form(body = '')
  fill_in 'topic_title', with: topic[:title]
  fill_in 'topic_body',  with: body
  click_button 'Create Topic'
end
