p 'Seed the development database ...'

p ' > primary user ...'

user = FactoryGirl.create(:confirmed_user,
                          username: 'toctan',
                          email: 'i@example.com')

p ' > primary node ...'

node = FactoryGirl.create(:node, name: 'fora')

FactoryGirl.create_list(:topic, 10, user: user, node: node)

p ' > topics ...'

FactoryGirl.create_list(:topic, 20, node: node)

p ' > primary topic ...'

topic = FactoryGirl.create(:topic_with_body, user: user, node: node)

FactoryGirl.create_list(:reply, 30, topic: topic)

p ' > primary Chinese topic ...'

cntopic = FactoryGirl.create(:topic,
                             title: Faker::LoremCN.sentence,
                             body:  Faker::LoremCN.paragraph,
                             node: node,
                             user: user)

30.times do
  FactoryGirl.create(:reply,
                     body: Faker::LoremCN.sentence,
                     topic: cntopic)
end

p 'Finish.'
