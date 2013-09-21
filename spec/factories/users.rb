FactoryGirl.define do
  factory :user do
    username 'test'
    email    'test@me.com'
    password 'password'

    factory :confirmed_user do
      confirmed_at Time.now
    end
  end
end
