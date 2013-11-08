require 'spec_helper'

feature 'Third party signin' do
  scenario 'via twitter' do
    mock_auth(:twitter)
    visit user_omniauth_authorize_url(:twitter)

    expect(page).to have_flash_message 'authenticated from twitter'
  end

  scenario 'via weibo' do
    mock_auth(:weibo)
    visit user_omniauth_authorize_url(:weibo)

    expect(page).to have_flash_message 'authenticated from weibo'
  end

  scenario 'when the username has been taken' do
    create(:user, username: 'nick')
    mock_auth(:twitter)
    visit user_omniauth_authorize_url(:twitter)

    expect(page).to have_selector('#new_user .form-field--error', count: 1)
    expect(page).to have_inline_help 'has already been taken'
  end

  scenario 'authrozation failed' do
    pending
    # TODO: omniauth does not fail with this message why?
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials

    visit user_omniauth_authorize_url(:twitter)

    expect(page).to have_flash_message 'invalid_credentials', 'error'
  end
end

def mock_auth(provider)
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      provider: provider.to_s,
      uid: '123545',
      info: {
        nickname: 'nick',
        image: 'http://lorempixel.com/400/200/'
      }
    })
end
