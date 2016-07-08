# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    user nil
    project nil
    role 1
    accepted 1
    user_email "MyString"
  end
end
