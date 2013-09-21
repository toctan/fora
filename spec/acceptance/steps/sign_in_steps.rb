module SignInSteps
  step 'I sign in with invalid data' do
    click_button "Sign in"
  end

  step 'I should see flash error message' do
    expect(page).to have_selector('div.alert.alert-alert', text: "Invalid login or password")
  end

  step 'I sign in with email' do
    user = FactoryGirl.create(:user)

    fill_in "Login", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"
  end

  step 'I sign in with username' do
    user = FactoryGirl.create(:user)

    fill_in "Login", with: user.username
    fill_in "Password", with: user.password

    click_button "Sign in"
  end

  step 'I should see flash success message' do
    expect(page).to have_selector('div.alert.alert-success', text: "Signed in successfully")
  end

end

RSpec.configure { |c| c.include SignInSteps }
