FactoryGirl.define do
  factory :comment do
    content 'Comment content'
    user
    post
  end
end
