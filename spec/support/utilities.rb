RSpec::Matchers.define :have_flash_message do |message, kind|
  kind ||= 'success'
  match do |page|
    page.should have_selector(".ui.message.#{kind}", text: message)
  end
end

RSpec::Matchers.define :have_inline_help do |msg|
  match do |page|
    page.should have_selector('.ui.red.label', text: msg)
  end
end
