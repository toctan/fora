module StaticPagesSteps
  step 'I should see sign_up sign_in links' do
    expect(page).to have_link('Sign up', href: new_user_registration_path)
    expect(page).to have_selector('#user-links .icon-signin')
  end

  step 'I should not see sign_up sign_in links' do
    expect(page).not_to have_selector('#user-links .icon-signin')
    expect(page).not_to have_link('Sign up', href: new_user_registration_path)
  end

  step 'I should see sign_out settings links' do
    expect(page).to have_selector('#user-links .icon-signout')
    expect(page).to have_selector('#user-links .icon-wrench')
  end
end

RSpec.configure { |c| c.include StaticPagesSteps }
