class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :applicant_id, comment: '申请者的id'
      t.string :reviewer1_username, comment: '1级审批人'
      t.integer :reviewer2_id, comment: '2级审批人'
      t.string :workflow_state, comment: "审批工作流的状态"
      t.integer :leave_kind, comment: '请假的种类，例如事假、婚假等等'
      t.date :start_at, comment: '请假开始的日期'
      t.date :end_at, comment: '请假结束的日期'
      t.text :leave_excuse, comment: '请假的理由'

      t.timestamps
    end
  end
end
