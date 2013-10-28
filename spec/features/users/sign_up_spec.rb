require 'spec_helper'

feature 'Visitor signs up' do
  let(:visitor) { attributes_for(:user) }

  scenario 'with valid data' do
    sign_up_with visitor
    expect(page).to have_flash_message 'message with a confirmation'

    click_confirmation_link
    expect(page).to have_flash_message 'successfully confirmed'
  end

  scenario 'with invalid email' do
    sign_up_with visitor.merge(email: 'invalid_email')

    expect(page).to have_inline_help 'is invalid'
  end

  scenario 'with blank password' do
    sign_up_with visitor.merge(password: '')

    expect(page).to have_inline_help "can't be blank"
  end
end

def sign_up_with(visitor)
  visit '/users/sign_up'

  visitor.each do |k, v|
    fill_in "user_#{k}", with: v
  end
  click_button 'Sign up'
end

def click_confirmation_link
  user = User.find_by email: visitor[:email]
  visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
end
