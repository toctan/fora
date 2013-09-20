module TopicSteps
  step 'there exists a bunch of topics' do
    21.times { FactoryGirl.create(:topic) }
  end

  step 'I should see these topics paginated' do
    expect(page).to have_selector('.topics .topic a', count: 20)
    expect(page).to have_selector('div.pagination')
  end

  step 'I click on one topic\'s title' do
    find('.topics .topic:first-child a').click
  end

  step 'I should see the topic\'s content' do
    expect(page).to have_selector('.topic-detail .content')
  end
end

RSpec.configure { |c| c.include TopicSteps }
