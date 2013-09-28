module NotificationSteps
  step 'someone mentions me in new :item' do |item|
    create(item, body: "@#{@user.username}")
  end
end

RSpec.configure { |c| c.include NotificationSteps }
