FactoryGirl.define do
  factory :node do
    user

    sequence(:name) { |n| "node#{n}" }
    key  { "#{name}" }
  end
end
