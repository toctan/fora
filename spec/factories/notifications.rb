FactoryGirl.define do
  factory :notification do
    association :target, factory: :user
    association :source, factory: :user
    topic

    kind 'mention'
  end
end
