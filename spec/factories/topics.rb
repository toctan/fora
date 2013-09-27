FactoryGirl.define do
  factory :topic do
    user
    title { Faker::Lorem.sentence }

    factory :topic_with_body do
      body { Faker::Lorem.paragraph }
    end
  end
end
