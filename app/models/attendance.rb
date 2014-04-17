class Attendance < ActiveRecord::Base
  belongs_to :applicant, class_name: "User",:foreign_key=>"applicant_id"
  belongs_to :reviewer1, class_name: "User"  ,:foreign_key=>"reviewer2_id"
 # belongs_to :reviewer2, class_name: "User"
  include SimpleEnum

  include Workflow
  workflow do
    state :new do
      event :submit, :transitions_to => :awaiting_review_by_1, :meta => {:validates_presence_of => [:applicant_id, :reviewer1_id]}
    end
    state :awaiting_review_by_1 do
      event :review, :transitions_to => :being_reviewed_by_1
    end
    state :being_reviewed_by_1 do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
    state :accepted
    state :rejected
  end 

  has_enum :leave_kinds ,:enums => [[:nianjia, 0, "年假"],[:hunjia, 1, "婚假"],[:shijia, 2, "事假"],[:bingjia, 3, "病假"],[:sangjia, 4, "丧假"],[:qita, 5, "其他"]], \
      :column => :leave_kind, :default => :shijia

  def submit
  end

  # 在这里就会涉及到 审批人的信息。（需要确定他是谁）
  def review
    # @applicant = User.where(job_id: self.applicant_id)  # 先获得 被 审批人的信息   
    # @reviewer = User.where(job_id: self.reviewer1_id)  # 再获得 审批者的信息   
    # puts self.current_state
    # 再干啥干啥。。。。
  end   

  def accept
    # self.result = true
    self.save
  end

  def reject
    # self.result = false
    self.save
  end

end
