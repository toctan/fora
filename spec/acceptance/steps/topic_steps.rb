module TopicSteps
  def topic
    @topic ||= FactoryGirl.attributes_for(:topic)
  end

  step 'there exists a bunch of topics' do
    FactoryGirl.create(:user) do |user|
      FactoryGirl.create_list(:topic, 21, user: user)
    end
  end

  step 'I click on one topic\'s title' do
    find('#topics p.topic:first-child a').click
  end

  step 'I should see the topic\'s content' do
    expect(page).to have_selector('.topic-detail .content')
  end

  step 'I (am) on/visit the new topic page' do
    visit '/topics/new'
  end

  step 'I submit with the topic\'s title' do
    fill_in 'Title', with: topic[:title]
    fill_in 'Body',  with:  topic[:body]
    click_button "Create Topic"
  end

  step "I should see the topic created" do
    expect(page).to have_selector('.topic-detail .title', text: topic[:title])
  end
end

RSpec.configure { |c| c.include TopicSteps }
