FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "node#{n}" }
    key  { "#{name}" }
  end
end
