FactoryGirl.define do
  factory :user do
    username 'test'
    email    'test@me.com'
    password 'password'
    confirmed_at DateTime.now()
  end
end
