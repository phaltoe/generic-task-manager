# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    description "MyString"
    project nil
    completed false
  end
end
