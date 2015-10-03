FactoryGirl.define do
  factory :user do
    nickname 'Nick'
    sequence(:email) { |n| "user#{n}@email.com" }
    password '12345678'
  end
end
