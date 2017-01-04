FactoryGirl.define do
  factory :todo do
    association :project
    sequence(:name) { |n| "todo#{n}" }
  end
end
