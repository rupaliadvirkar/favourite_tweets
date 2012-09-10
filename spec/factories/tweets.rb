# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet, :class => Tweet do
    twitter_created_at Time.now()
    from_user "Test"
    from_user_id 1234
    profile_image_url "http://test1.com"
    text "ruby on rails"
  end
end
