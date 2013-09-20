FactoryGirl.define do
  factory :topic do
    sequence(:title) { |n| "Lorem ipsum dolor sit amet (#{n})" }
    body  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.'
  end
end
