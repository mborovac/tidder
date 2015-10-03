FactoryGirl.define do
  factory :subreddit do
    sequence(:name) { |n| "subreddit#{n}" }
    description 'Subreddit description'
  end
end
