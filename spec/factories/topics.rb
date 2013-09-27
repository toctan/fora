FactoryGirl.define do
  factory :topic do
    user

    sequence(:title) { |n| "a" * 90 + "(#{n})" }

    factory :topic_with_body do
      body 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Lorem ipsum dolor sit amet, consectetuer adipiscing elit.Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
    end
  end
end
