FactoryGirl.define do
  factory :project do
    association :team
    sequence(:name) { |n| "project#{n}"}
  end
end
