module NotificationSteps
  step 'I am on the notification page' do
    visit '/notifications'
  end

  step 'someone mentions me in new :item' do |item|
    create(item, body: "@#{@user.username}")
  end

  step 'another user mentiones me in my topic\'s reply' do
    create(:reply, topic: @topic, body: "@#{@user.username}")
  end

  step 'there exists a bunch of notifications' do
    @notifications = create_list(:notification_mention, 3, user: @user)
  end

  step 'I click delete on one of the notifications' do
    within '#notifications' do
      first('.notification-item').click_link 'Delete'
    end
  end

  step 'I should see this notification removed' do
    step "I should see only #{@notifications.count - 1} new notifications"
  end

  step 'I click button Clear' do
    click_link 'Clear'
  end

  step 'I should see new notification' do
    expect(page).to have_selector('.notification-indicator')
  end

  step 'I should not see the notification indicator' do
    expect(page).not_to have_selector('.notification-indicator')
  end

  step 'I should see only :count new notification(s)' do |count|
    expect(page).to have_selector('.notification-item', count: count)
  end

  step 'I should see those notifications' do
    step "I should see only #{@notifications.count} new notifications"
  end

  step 'I should see no notifications' do
    expect(page).not_to have_selector('.notification-item')
  end
end

RSpec.configure { |c| c.include NotificationSteps }
