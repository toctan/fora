FactoryGirl.define do
  factory :node do
    user

    sequence(:name) { |n| "node#{n}" }
    key  { "#{name}" }

    factory :approved_node do
      approved true
    end
  end
end
