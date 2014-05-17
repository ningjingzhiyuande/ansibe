# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :procedure do
    user_id 1
    entry_id 1
    entry_type "MyString"
    reporter_id 1
    state 1
    position "MyString"
  end
end
