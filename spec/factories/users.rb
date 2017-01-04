FactoryGirl.define do
  factory :user do
    sequence(:nickname) { |n| "nickname#{n}" }
    sequence(:email) { |n| "email#{n}@tawa.com" }
    password 'password'
  end
end
