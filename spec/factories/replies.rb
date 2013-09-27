# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    user
    topic

    body { Faker::Lorem.sentence }
  end
end
