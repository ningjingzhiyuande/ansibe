class User < ActiveRecord::Base
  include SimpleEnum
  #rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  has_many :attendances, foreign_key: "applicant_id"
  has_many :review_attendances,class_name: "Attendance", foreign_key: "reviewer2_id"
  has_many :net_cards, foreign_key: "applicant_id"
  has_many :entretains
  has_many :report_entretains, foreign_key: "reporter_id",class_name: "Entretain"
  #,[:admin, 300, "管理员"]
  has_enum :roles ,:enums => [[:user, 0, "用户"],[:chief, 100, "处长"],[:chairman, 200, "主任"]], \
      :column => :role, :default => :user

  has_enum :departments ,:enums => [[:caigou, 0, "采购部"],[:zongguan, 1, "综合管理处"],[:jihua, 2, "计划处"],\
           [:hetong, 3, "合同管理处"],[:jiyi, 4, "机械一处"],[:jier, 5, "机械二处"],[:yikong, 3, "仪控处"],[:dianqi, 6, "电气处"],\
           [:jianzao, 7, "监造处"],[:zhibao, 8, "质量保证处"],[:xitong, 9, "系统设备及大宗材料处"]], 
      :column => :department, :default => :caigou
  #belongs_to :department

  def admin?
  	#true
  	 role==300
  end

  def leaders
     return if role>200
     User.where("department=? and role> ? and role!=?",department,role,300).select(:name,:id)
  end
end

