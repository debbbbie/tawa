FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "team#{n}" }
    association :owner, factory: :user
  end
end
