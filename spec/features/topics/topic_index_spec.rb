require 'spec_helper'

feature 'visit topic index page' do
  scenario 'user should see node bar' do
    visit topics_path

    expect(page).to have_selector('#node-bar')
    expect(page).not_to have_selector('#node-bar a.btn')
  end

  context 'when nodes are too many to fit into the bar' do
    before do
      create_list(:node, 30)
      visit topics_path
    end

    scenario 'user should see only 10 nodes and more button' do
      expect(page).to have_selector('#node-bar li a:not(.btn)', count: 10)
      expect(page).to have_selector('#node-bar a.btn')
    end
  end
end
