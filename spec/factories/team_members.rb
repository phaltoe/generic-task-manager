# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_member do
    user nil
    project nil
    role 1
    accepted false
    invited_email "MyString"
  end
end
