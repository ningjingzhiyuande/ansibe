class Entretain < ActiveRecord::Base
	belongs_to :user
	belongs_to :report_user,foreign_key: "reporter_id",class_name: "User"
	after_save :send_apply_mail,:if => Proc.new{|r| r.aasm_state_changed? && r.aasm_state=="auditting"} 
	after_save :send_finished_mail,:if => Proc.new{|r| r.aasm_state_changed? && (["acceptting","rejectting"].include? r.aasm_state)} 
  
  include SimpleEnum
  has_enum :titles ,:enums => [[:fuqing12, 1, "福清12"],[:fuqing34, 2, "福清34"],[:fuqing56, 3, "福清56"], \
          [:fangjiashan, 4, "方家山"],[:hainan, 5, "海南"],[:tianwan34, 6, "田湾34"],[:xudapu, 7, "徐大堡"],\
          [:baeryi, 8, "821"],[:others, 9, "其他"]], :column => :title, :default => :fuqing12
  has_enum :locations, :enums => [[:xiangechun, 1, "湘鄂春"], [:lingdian, 2 , "零点餐厅"],\
         [:others, 3, "其他"]], :column => :location, :default => :xiangechun

  include AASM
	mount_uploader :attache, AttacheUploader
	aasm do # default column: aasm_state
      state :applying, :initial => true
      state :auditting
      state :acceptting
      state :rejectting
      event :audit do
         transitions :from => :applying, :to => :auditting#, :guard => :send_apply_mail
      end
      event :accept do
      	 transitions :from => :auditting, :to => :acceptting#, :guard => :send_finished_mail
      end
      event :reject do
      	 transitions :from => :auditting, :to => :rejectting#, :guard => :send_finished_mail
      end
    end
    def set_state
    	self.audit! if aasm_state=="applying" && !reporter_id.blank?
    end

    def send_apply_mail
    	EntretainMail.send_apply_mail(self).deliver
    end
    def send_finished_mail
    	EntretainMail.send_finished_mail(self).deliver
    end


    def self.report_user(user)
    	User.where(role:[100,200]).where(department: [user.department, 6100]).select(:id,:name).collect{|u|[u.name,u.id]}   	
    end
    def is_reporter?(user_id)
    	reporter_id==user_id
    end

end
