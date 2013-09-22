module UserSteps
  def visitor
    @visitor ||= FactoryGirl.attributes_for(:user)
  end

  step "I am signed in" do
    login_as FactoryGirl.create(:confirmed_user), scope: :user
  end

  step "I am not signed in" do
    visit '/users/sign_out'
  end

  step "I sign up with valid data" do
    visit '/users/sign_up'
    fill_in 'Username', with: visitor[:username]
    fill_in 'Email',    with: visitor[:email]
    fill_in 'Password', with: visitor[:password]
    click_button "Sign up"
  end

  step "I should see confirmation email message" do
    expect(page).to have_selector('.alert', text: 'message with a confirmation')
  end

  step "I click the confirmation link" do
    user = User.find_by email: @visitor[:email]
    visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
  end

  step "I should see account confirmed message" do
    expect(page).to have_selector('.alert', text: 'successfully confirmed')
  end
end

RSpec.configure { |c| c.include UserSteps }
