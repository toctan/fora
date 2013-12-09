RSpec.configure do |config|
  config.before(:each, signin: true) do
    @current_user ||= create(:user,
      provider: 'twitter',
      uid: '1')
    visit '/auth/twitter'
  end

  config.after(:each, signin: true) do
    @current_user.destroy
  end

  config.before(:each, admin: true) do
    @current_user ||= create(:admin,
      provider: 'twitter',
      uid: '1')
    visit '/auth/twitter'
  end

  config.after(:each, admin: true) do
    @current_user.destroy
  end
end

RSpec::Matchers.define :have_flash_message do |message, kind|
  kind ||= 'notice'
  match do |page|
    page.should have_selector(".flash.flash--#{kind}", text: message)
  end
end

RSpec::Matchers.define :have_inline_help do |msg|
  match do |page|
    page.should have_selector('.error', text: msg)
  end
end
