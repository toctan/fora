require 'spec_helper'

feature 'Admin', :admin do
  let(:topic) { create(:topic) }
  let!(:reply) { create(:reply, topic: topic) }

  before(:each) { visit topic_path(topic) }

  scenario 'delete spam reply', :js do
    find('.js-delete-reply').click

    expect(page).to have_selector('.reply', count: 0)
  end
end
