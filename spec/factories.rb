FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "test#{n}" }

    factory :admin do
      admin true
    end
  end

  factory :notification do
    association :target, factory: :user
    association :source, factory: :user
    topic

    kind 'mention'
  end

  factory :node do
    user

    sequence(:name) { |n| "node#{n}" }
    key  { "#{name}" }

    factory :approved_node do
      approved true
    end
  end

  factory :reply do
    user
    topic

    body 'wat'
  end

  factory :topic do
    node
    user
    title 'wat'

    factory :topic_with_body do
      body 'wat body'
    end
  end
end
