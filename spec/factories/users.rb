# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "test1@test.com"
    password "password"
  end
  
  factory :user1, :class => User do
    email "test2@test.com"
    password "password"
  end

end
