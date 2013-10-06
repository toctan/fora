require 'spec_helper'

feature 'Node page' do
  let(:node) { create(:node, name: 'movie') }
  before(:each) { create_list(:topic, 8, node: node) }

  scenario 'User visits an existed node' do
    visit go_path(node.key)

    within '#topics' do
      expect(page).to have_selector('.topic-item', count: 8)
    end
  end

  scenario 'User visits an unexisted node' do
    visit '/go/unexisted'

    expect(page).to have_flash_message('No such node', 'alert')
  end

  scenario 'User visits index page about node' do
    visit '/nodes'

    expect(page).to have_selector('#nodes p a', count: 1)
  end
end
