require 'spec_helper'

feature 'Admin' do
  let(:topic) { create(:topic) }
  let!(:reply) { create(:reply, topic: topic) }

  before(:each) { visit topic_path(topic) }

  scenario 'delete spam reply', :admin do
    find('.js-delete-reply').click

    expect(page).to have_selector('.reply-item', count: 0)
  end
end
