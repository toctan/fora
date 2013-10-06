require 'spec_helper'

feature 'Visitor signs up via twitter' do
  scenario 'authorized successfully' do
    visit user_omniauth_authorize_url(:twitter)

    expect(page).to have_flash_message 'Successfully authenticated from twitter'
  end
end
