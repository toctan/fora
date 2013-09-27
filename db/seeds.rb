p 'Seed the development database ...'

p ' > primary user ...'

user = FactoryGirl.create(:confirmed_user,
                          username: 'toctan',
                          email: 'i@example.com')

FactoryGirl.create_list(:topic, 10, user: user)

p ' > topics ...'

FactoryGirl.create_list(:topic, 20)

p ' > primary topic ...'

topic = FactoryGirl.create(:topic_with_body, user: user)

FactoryGirl.create_list(:reply, 30, topic: topic)

p ' > primary chinese topic ...'

cntopic = FactoryGirl.create(:topic,
                             title: Faker::LoremCN.sentence,
                             body:  Faker::LoremCN.paragraph,
                             user: user)

30.times do
  FactoryGirl.create(:reply,
                     body: Faker::LoremCN.sentence,
                     topic: cntopic)
end

p 'Finish.'
