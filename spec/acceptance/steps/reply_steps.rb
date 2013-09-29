module ReplySteps
  def reply
    @reply ||= create(:reply)
  end

  step 'there exists a bunch of replies of a topic' do
    user = create(:user)
    @topic = create(:topic, user: user)

    create_list(:reply, 25, user: user, topic: @topic)
  end

  step 'another user replies my topic' do
    create(:reply, topic: @topic)
  end

  step 'I visit the topic' do
    visit topic_path @topic
  end

  step 'I should only see the first :num :items' do |num, items|
    expect(page).to have_selector("##{items} div.#{items.singularize}-item", count: num)
    expect(page).to have_selector('div.pagination')
  end

  step 'I should see a reply form' do
    expect(page).to have_selector('form#new_reply')
  end

  step 'I submit the form with my reply' do
    fill_in 'reply_body', with: reply[:body]

    click_button 'Create Reply'
  end

  step 'I should see my reply on the bottom' do
    expect(page).to have_selector('#replies .reply-item:last-child', text: reply[:body])
  end
end

RSpec.configure { |c| c.include ReplySteps }
