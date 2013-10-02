include ApplicationHelper

def sign_in_as(type)
  user = create(type)
  sign_in user
  user
end

RSpec::Matchers.define :have_flash_message do |message, kind|
  kind ||= 'success'
  match do |page|
    page.should have_selector(".alert.alert-#{kind}", text: message)
  end
end

RSpec::Matchers.define :have_inline_help do |msg|
  match do |page|
    page.should have_selector('span.help-inline', text: msg)
  end
end
