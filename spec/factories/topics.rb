FactoryGirl.define do
  factory :topic do
    user

    sequence(:title) { |n| "Lorem ipsum dolor sit amet (#{n})" }

    factory :topic_with_body do
      body 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    end
  end
end
