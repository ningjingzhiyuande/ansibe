json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :applicant_id, :reviewer1_id, :reviewer2_id, :workflow_state, :leave_kind, :start_at, :end_at
  json.url attendance_url(attendance, format: :json)
end
