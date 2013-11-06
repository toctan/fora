require 'spec_helper'

feature 'User signs in' do
  background do
    visit new_user_session_path
  end

  let(:user) { create(:confirmed_user) }

  scenario 'with email' do
    fill_sign_in_form('email')

    expect(page).to have_flash_message 'Signed in successfully'
  end

  scenario 'with username' do
    fill_sign_in_form('username')

    expect(page).to have_flash_message 'Signed in successfully'
  end

  scenario 'with invalid credential' do
    fill_sign_in_form('invalid')

    expect(page).to have_flash_message 'Invalid login or password', 'error'
  end
end

def fill_sign_in_form(login)
  unless login == 'invalid'
    fill_in 'user_login',    with: user.send(login)
    fill_in 'user_password', with: user.password
  end

  click_button 'Sign in'
end
