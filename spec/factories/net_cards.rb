# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :net_card do
    applicant_id 1
    reviewer1_username "MyString"
    reviewer2_username "MyString"
    workflow_state "MyString"
    start_at "2014-04-13"
    end_at "2014-04-13"
    quantity 1
  end
end
