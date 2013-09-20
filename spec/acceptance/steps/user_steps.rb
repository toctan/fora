module UserSteps
  def visitor
    @visitor ||= FactoryGirl.attributes_for(:user)
  end

  step "I am not signed in" do
    visit '/users/sign_out'
  end

  step "I sign up with valid data" do
    visit '/users/sign_up'
    fill_in 'user_username', with: visitor[:username]
    fill_in 'user_email',    with: visitor[:email]
    fill_in 'user_password', with: visitor[:password]
    click_button 'Sign up'
  end

  step "I should see confirmation email message" do
    expect(page).to have_selector('.alert', text: 'message with a confirmation')
  end

  step "I click the confirmation link" do
    user = User.find(email: @visitor[:email])
    visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
  end

  step "I should see account confirmed message" do
    expect(page).to have_selector('.alert', text: 'successfully confirmed')
  end
end

RSpec.configure { |c| c.include UserSteps }
