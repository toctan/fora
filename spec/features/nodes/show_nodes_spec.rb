require 'spec_helper'

feature 'Node page' do
  before do
    create_list(:node, 30)
    visit '/nodes'
  end

  scenario 'user browse all the nodes' do
    expect(page).to have_content('There are 30 nodes')

    within '#nodes .content' do
      expect(page).to have_selector('span.item', count: 30)
    end
  end
end
