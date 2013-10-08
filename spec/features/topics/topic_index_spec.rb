require 'spec_helper'

feature 'visit topic index page' do
  before do |variable|
    Node.delete_all
  end

  scenario 'user should see node bar' do
    visit topics_path

    expect(page).to have_selector("#node-bar")
    expect(page).not_to have_selector("#node-bar a.btn")
  end

  context "when node is too many" do
    before(:each) do
      create_list(:node, 30)
      visit topics_path
    end

    scenario 'user should see all nodes button and only 10 nodes' do
      expect(page).to have_selector("#node-bar li a:not(.btn)", count: 10)
      expect(page).to have_selector("#node-bar a.btn")
    end

    scenario 'click all nodes button should see all nodes' do
      click_link "All nodes"

      expect(page).to have_selector("span.item", count: 30)
    end

    scenario 'click one node should see breadcrumb' do
      click_link Node.first.name

      expect(page).to have_selector("ul.breadcrumb")
    end

  end

end
