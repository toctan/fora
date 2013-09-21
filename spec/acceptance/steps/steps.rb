step 'I visit the homepage' do
  visit '/'
end

step "I am not signed in" do
  visit '/users/sign_out'
end

  step "I am signed in" do
    @user = FactoryGirl.create(:user)

    visit '/users/sign_in'
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign in"
  end
