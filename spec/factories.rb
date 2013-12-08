FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "test#{n}" }
    sequence(:email)    { |n| "test#{n}@me.com" }
    password 'password'

    factory :confirmed_user do
      confirmed_at Time.now

      factory :admin do
        admin true
      end
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
