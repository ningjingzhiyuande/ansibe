class CreateLeaveKinds < ActiveRecord::Migration
  def change
    create_table :leave_kinds do |t|
      t.integer :attendance_id, comment: "reference key"
      t.string :name, comment: "请假类别的名字"
      t.integer :lv1, comment: "一级级别的假期长度"
      t.integer :lv2, comment: "二级级别的假期长度"
      t.integer :lv3, comment: "三级级别的假期长度"


      t.timestamps
    end
  end
end
