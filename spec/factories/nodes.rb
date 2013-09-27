# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    name 'node'
    key  { "#{name}" }
  end
end
