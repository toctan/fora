module UserSteps
  def visitor
    @visitor ||= FactoryGirl.attributes_for(:user)
  end

  def fill_sign_in_form(login)
    fill_in 'Login',    with: @user.send(login)
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  step 'I sign up with valid data' do
    visit '/users/sign_up'

    fill_in 'Username', with: visitor[:username]
    fill_in 'Email',    with: visitor[:email]
    fill_in 'Password', with: visitor[:password]
    click_button 'Sign up'
  end

  step 'I click the confirmation link' do
    user = User.find_by email: @visitor[:email]
    visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
  end

  step 'I am a signed up user' do
    @user = FactoryGirl.create(:confirmed_user)
  end

  step 'I am on sign in page' do
    visit new_user_session_path
  end

  step 'I sign in with invalid data' do
    click_button 'Sign in'
  end

  step 'I sign in with email' do
    fill_sign_in_form('email')
  end

  step 'I sign in with username' do
    fill_sign_in_form('username')
  end

  step 'I am signed in' do
    @user = FactoryGirl.create(:confirmed_user)
    login_as @user, scope: :user
  end

  step 'I am not signed in' do
    visit '/users/sign_out'
  end
end

RSpec.configure { |c| c.include UserSteps }
