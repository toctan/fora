# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    user
    topic
    sequence(:body) { |n| "Lorem ipsum dolor sit amet (#{n})" }
  end
end
