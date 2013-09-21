module StaticPagesSteps

  step "I visit /" do
    visit root_path
  end

  step "I should see sign_up sign_in links" do
    expect(page).to have_link("Sign up", href: new_user_registration_path)
    expect(page).to have_link("Sign in", href: new_user_session_path)
  end

  step "I should not see sign_up sign_in links" do
    expect(page).not_to have_link("Sign in", href: new_user_registration_path)
    expect(page).not_to have_link("Sign up", href: new_user_registration_path)
  end

  step "I should see sign_out settings links" do
    expect(page).to have_link("Sign out", href: destroy_user_session_path)
    expect(page).to have_link(@user.username, href: edit_user_registration_path)
  end

  step "I should not see sign_out settings links" do
    expect(page).not_to have_link("Sign out", href: destroy_user_session_path)
    expect(page).not_to have_link(@user.username, href: edit_user_registration_path)
  end

  step "I click sign_out link" do
    click_link "Sign out"
  end




end

RSpec.configure { |c| c.include StaticPagesSteps }