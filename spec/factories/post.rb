FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "post#{n}" }
    content 'Post content'
    user
    subreddit
  end
end
