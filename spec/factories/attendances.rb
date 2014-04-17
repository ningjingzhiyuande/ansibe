# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    applicant_id 1
    reviewer1_id 1
    reviewer2_id 1
    workflow_state "MyString"
    leave_kind "MyString"
    start_at "2014-04-11"
    end_at "2014-04-11"
  end
end
