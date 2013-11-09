RSpec.configure do |config|
  config.before(:each, signin: true) do
    @current_user ||= create(:confirmed_user)
    login_as @current_user, scope: :user
  end

  config.after(:each, signin: true) do
    @current_user.destroy
  end

  config.before(:each, admin: true) do
    @current_user ||= create(:admin)
    login_as @current_user, scope: :user
  end

  config.after(:each, admin: true) do
    @current_user.destroy
  end
end

RSpec::Matchers.define :have_flash_message do |message, kind|
  kind ||= 'success'
  match do |page|
    page.should have_selector(".ui.message.#{kind}", text: message)
  end
end

RSpec::Matchers.define :have_inline_help do |msg|
  match do |page|
    page.should have_selector('.error', text: msg)
  end
end
