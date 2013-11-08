require 'spec_helper'

feature 'New node' do
  let(:node) { attributes_for(:node) }

  scenario 'user propose a new node successfully', :signin do
    fill_new_node_form

    expect(page).to have_flash_message I18n.t('propose_node_success')

    visit node_path(node)

    expect(page).to have_flash_message(I18n.t('node_not_approved'), 'error')
  end

  context 'when admin propose a new node' do
    before(:each) do
      login_as create(:admin), scope: :user
    end

    scenario 'node get approved immediately' do
      fill_new_node_form

      expect(page).to have_flash_message I18n.t('create_node_success')

      visit node_path(node)
      # TODO: This should be tested in anther way
      expect(page).to have_selector('body.nodes-show')
    end
  end
end

def fill_new_node_form
  visit new_node_path
  fill_in 'node_key', with: node[:key]
  fill_in 'node_name', with: node[:name]
  click_button 'Create Node'
end
