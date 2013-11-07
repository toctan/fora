p 'Seed the development database ...'

p ' > primary user ...'

FactoryGirl.create(:confirmed_user, username: 'toctan',
                   email: 'tianjin.sc@gmail.com')

imgs = [
  "http://cdn.v2ex.com/avatar/4f5c/422f/4680_large.png",
  "http://cdn.v2ex.com/avatar/b1c1/4790/10973_large.png",
  "http://cdn.v2ex.com/avatar/9bf3/1c7f/15_large.png",
  "http://cdn.v2ex.com/avatar/40dd/dac8/23308_large.png",
  "http://cdn.v2ex.com/avatar/ad7b/25e2/19048_large.png"
]

imgs.each do |img|
  FactoryGirl.create(:confirmed_user, avatar_remote_url: img)
end

p ' > primary node ...'

FactoryGirl.create(:node, key: 'idea', name: 'idea')

p 'Finish.'
