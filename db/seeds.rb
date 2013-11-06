p 'Seed the development database ...'

p ' > primary user ...'

FactoryGirl.create(:confirmed_user, username: 'toctan',
                   email: 'tianjin.sc@gmail.com')

p ' > primary node ...'

FactoryGirl.create(:node, key: 'iGame', name: 'iGame')

p 'Finish.'
