FactoryGirl.define do
  factory :user do
    username 'test'
    email    'test@me.com'
    password 'password'

    factory :confirmed_user do
      confirmed_at Time.now
    end

    factory :avatar_user do
      avatar_file_name    "test.png"
      avatar_content_type "image/png"
      avatar_file_size    "1026"
    end
  end
end
