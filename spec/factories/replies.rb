# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    user
    topic
    sequence(:body) { |n| "LLLLLorem ipsum dolor sit amet, consectetuer adipiscing elit.orem ipsum dolor sit amet, consectetuer adipiscing elit.orem ipsum dolor sit amet, consectetuer adipiscing elit.orem ipsum dolor sit amet, consectetuer adipiscing elit.orem ipsum dolor sit amet, consectetuer adipiscing elit.Lorem ipsum dolor sit amet (#{n})" }
  end
end
