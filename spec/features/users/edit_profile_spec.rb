require 'spec_helper'

feature 'User edits his profile' do
  let(:user) { create(:confirmed_user) }

  background do
    login_as user, scope: :user
    visit edit_user_registration_path
  end

  scenario 'change username' do
    fill_in 'user_username', with: 'whatever'
    click_button 'Update'

    expect(page).to have_flash_message 'You updated your account successfully.'
  end

  scenario 'change password with current password' do
    fill_in_password

    expect(page).to have_flash_message 'You updated your account successfully.'
  end

  scenario 'change password without current password' do
    fill_in_password false

    within '.user_current_password' do
      expect(page).to have_inline_help "can't be blank"
    end
  end
end

def fill_in_password(current = true)
  fill_in 'user_password',              with: 'whatever'
  fill_in 'user_password_confirmation', with: 'whatever'
  fill_in 'user_current_password',      with: user.password if current
  click_button 'Update'
end
