module UserSteps
  def path_to(page_name)
    case page_name
    when /^homepage$/i
      root_path
    when /^sign_in$/i
      new_user_session_path
    when /^settings$/i
      edit_user_registration_path
    when /^notification$/i
      notifications_path
    when /^topic$/i
      topic_path @topic
    else
      page_name
    end
  end

  def visitor
    @visitor ||= attributes_for(:user)
  end

  def fill_sign_in_form(login)
    unless login == 'invalid'
      fill_in 'Login',    with: @user.send(login)
      fill_in 'Password', with: @user.password
    end

    click_button 'Sign in'
  end

  def fill_in_update_form(update_item, password = nil)
    if password
      fill_in 'Current password', with: @user.password
    end

    if update_item == 'password'
      fill_in 'Password', with: @user.password + 'update'
      fill_in 'Password confirmation', with: @user.password + 'update'
    else
      fill_in update_item.capitalize, with: @user.send(update_item) + 'update'
    end

    click_button 'Update'
  end

  step 'I sign up with valid data' do
    visit '/users/sign_up'

    visitor.each do |k, v|
      fill_in "user_#{k}", with: v
    end

    click_button 'Sign up'
  end

  step 'I click the confirmation link' do
    user = User.find_by email: @visitor[:email]
    visit('/users/confirmation?confirmation_token=' + user.confirmation_token)
  end

  step 'I am a signed up user' do
    @user = create(:confirmed_user)
  end

  step 'I sign in with :login' do |login|
    fill_sign_in_form(login)
  end

  step 'I am signed in' do
    step 'I am signed in as confirmed_user'
  end

  step 'I am signed in as :role' do |role|
    @user = create(role)
    login_as @user, scope: :user
  end

  step 'I am not signed in' do
    visit '/users/sign_out'
  end

  step 'I update :update_item without password' do |update_item|
    fill_in_update_form(update_item)
  end

  step 'I update :update_item with password' do |update_item|
    fill_in_update_form(update_item, true)
  end

  step 'I visit an existed topic' do
    @user ||= create(:user)
    @topic = create(:topic, user: @user)

    visit topic_path @topic
  end

  step 'I should see star' do
    expect(page).to have_link('star', href: star_topic_path(@topic))
  end

  step 'I should not see star' do
    expect(page).not_to have_link('star', href: star_topic_path(@topic))
  end

  step 'I should see unstar' do
    expect(page).to have_link('unstar', href: unstar_topic_path(@topic))
  end

  step 'I should see delete link' do
    expect(page).to have_link('delete', href: topic_path(@topic))
  end

  step 'I should not see delete link' do
    expect(page).not_to have_link('delete', href: topic_path(@topic))
  end
end

RSpec.configure { |c| c.include UserSteps }
