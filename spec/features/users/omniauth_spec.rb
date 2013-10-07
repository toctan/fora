require 'spec_helper'

feature 'Users get authenticated' do
  scenario 'via twitter' do
    visit user_omniauth_authorize_url(:twitter)

    expect(page).to have_flash_message 'authenticated from twitter'
  end

  scenario 'via weibo' do
    visit user_omniauth_authorize_url(:weibo)

    expect(page).to have_flash_message 'authenticated from weibo'
  end
end
