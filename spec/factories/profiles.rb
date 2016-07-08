# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    association :user
    username { Faker::Internet.user_name(6..15) }
    website { Faker::Internet.url('example.org') }
  end
end
