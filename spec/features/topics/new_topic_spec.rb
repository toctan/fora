require 'spec_helper'

feature 'New topic' do
  let(:node)  { create(:node) }
  let(:topic) { create(:topic) }

  context 'When user is signed in', :signin do
    before(:each) do
      visit "/new/#{node.key}"
    end

    scenario 'Posts a new topic with blank body' do
      fill_new_topic_form

      within '#topic-header .main' do
        expect(page).to have_selector('h3', text: topic[:title])
      end
    end

    scenario 'Posts a new topic with a youtube video', :js do
      pending 'fuck GFW'
      fill_new_topic_form('http://www.youtube.com/watch?v=eIZTMVNBjc4')

      within '.topic-content' do
        expect(page).to have_selector('//iframe[@src="//www.youtube.com/embed/eIZTMVNBjc4"]')
      end
    end

    scenario 'Posts a new topic with a youku video' do
      fill_new_topic_form('http://v.youku.com/v_show/id_XNDk0MTU1OTIw')

      expect(page).to have_selector('//*[@id="topic-detail"]/div[2]/p/embed')
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
