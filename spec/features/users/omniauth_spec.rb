require 'spec_helper'

feature 'Third party signin' do
  scenario 'via twitter' do
    visit '/auth/twitter'

    expect(page).to have_link I18n.t('sign_out'), href: sign_out_path
  end

  scenario 'when the username has been taken' do
    create(:user, username: 'nick')
    visit '/auth/twitter'

    expect(page).to have_inline_help 'has already been taken'

    fill_in 'user_username', with: 'nikk'
    click_button 'Sign up'

    expect(page).to have_link I18n.t('sign_out'), href: sign_out_path
  end

  scenario 'authrozation failed' do
    OmniAuth.config.mock_auth[:weibo] = :invalid_credentials

    visit '/auth/weibo'
    expect(page).to have_flash_message 'invalid_credentials', 'alert'
  end
end
