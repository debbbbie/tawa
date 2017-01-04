FactoryGirl.define do
  factory :access do
    association :project
    association :user
  end
end
