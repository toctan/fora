module ReplySteps
  step "there exists a bunch of replies of a topic" do
    @user = FactoryGirl.create(:user)
    @topic = FactoryGirl.create(:topic, user: @user)

    FactoryGirl.create_list(:reply, 25, user: @user, topic: @topic)
  end

  step "I visit the topic" do
    visit topic_path @topic
  end

  step "I should only see the first :num :items" do |num, items|
    expect(page).to have_selector("##{items} p.#{items.singularize}", count: num.to_i)
    expect(page).to have_selector('div.pagination')
  end
end

RSpec.configure { |c| c.include ReplySteps }
