FactoryGirl.define do
  factory :topic do
    node
    user
    title 'wat'

    factory :topic_with_body do
      body 'wat body'
    end
  end
end
