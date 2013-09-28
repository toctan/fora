module UserSteps
  def visitor
    @visitor ||= attributes_for(:user)
  end

  def fill_sign_in_form(login)
    fill_in 'Login',    with: @user.send(login)
    fill_in 'Password', with: @user.password

    click_button 'Sign in'
  end

  def fill_edit_form(valid)

    if valid == "illegal"
      attach_file "Avatar", "spec/assets/#{valid}.txt"
    else
      attach_file "Avatar", "spec/assets/#{valid}.jpg"
    end

    fill_in "Current password", with: @user.password
    click_button "Update"
  end

  def fill_sign_up_form
    fill_in 'Username',    with: visitor[:username]
    fill_in 'Email', with: visitor[:email]
    fill_in 'Password', with: visitor[:password]

    click_button 'Sign up'
  end

  def fill_in_update_form(update_item, password = nil)
    if password
      fill_in "Current password", with: @user.password
    end

    if update_item == 'password'
      fill_in 'Password', with: @user.password + 'update'
      fill_in 'Password confirmation', with: @user.password + 'update'
    else
      fill_in update_item.capitalize, with: @user.send(update_item) + "update"
    end

    click_button "Update"
  end

  step 'I sign up with valid data' do
    visit '/users/sign_up'

    fill_sign_up_form
  end

  step 'I click the confirmation link' do
    user = User.find_by email: @visitor[:email]
    visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
  end

  step 'I am a signed up user' do
    @user = create(:confirmed_user)
  end

  step 'I am on sign in page' do
    visit new_user_session_path
  end

  step 'I am on update/edit page' do
    visit edit_user_registration_path
  end

  step 'I sign in with invalid data' do
    click_button 'Sign in'
  end

  step 'I sign in with :login' do |login|
    fill_sign_in_form(login)
  end

  step 'I am signed in' do
    @user = create(:confirmed_user)
    login_as @user, scope: :user
  end

  step 'I am not signed in' do
    visit '/users/sign_out'
  end

  step 'I upload with :type image' do |type|
    fill_edit_form(type)
  end

  step "I update :update_item without password" do |update_item|
    fill_in_update_form(update_item)
  end

  step "I update :update_item with password" do |update_item|
    fill_in_update_form(update_item, true)
  end

  step "I visit an existed topic" do
    @user ||= create(:user)
    @topic = create(:topic, user:@user)

    visit topic_path @topic
  end

  step "I should see star" do
    expect(page).to have_link("star", href: star_topic_path(@topic))
  end

  step "I should not see star" do
    expect(page).not_to have_link("star", href: star_topic_path(@topic))
  end

  step "I should see unstar" do
    expect(page).to have_link("unstar", href: unstar_topic_path(@topic))
  end
end

RSpec.configure { |c| c.include UserSteps }
