# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title       { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.paragraph }
    association :owner, :factory => :user 
  end
end
