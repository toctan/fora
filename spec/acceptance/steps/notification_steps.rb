module NotificationSteps
  step 'someone mentions me in new :item' do |item|
    create(item, body: "@#{@user.username}")
  end

  step 'another user mentiones me in my topic\'s reply' do
    create(:reply, topic: @topic, body: "@#{@user.username}")
  end

  step 'I should see new notification' do
    expect(page).to have_selector('.notification-indicator')
  end

  step 'I should not see the notification indicator' do
    expect(page).not_to have_selector('.notification-indicator')
  end

  step 'I should see only one new notification' do
    expect(page).to have_selector('.notification-item', count: 1)
  end
end

RSpec.configure { |c| c.include NotificationSteps }
