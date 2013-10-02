require 'spec_helper'

feature 'Signed in user changes his avatar to', :signin do
  before(:each) do
    visit edit_user_registration_path
  end

  scenario 'valid image' do
    attach_avatar 'spec/assets/valid.jpg'

    expect(page).to have_flash_message 'You updated your account'
  end

  scenario 'huge image' do
    attach_avatar 'spec/assets/huge.jpg'

    expect(page).to have_inline_help 'must less than 500KB'
  end

  scenario 'illegal file' do
    attach_avatar 'spec/assets/illegal.txt'

    expect(page).to have_inline_help 'is invalid'
  end
end

def attach_avatar(file)
  attach_file 'Avatar', file
  click_button 'Update'
end
