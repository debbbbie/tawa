FactoryGirl.define do
  factory :comment do
    association :todo
    association :user
    sequence(:content) { |n| "content#{n}" }
  end
end
