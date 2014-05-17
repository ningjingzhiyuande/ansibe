class Entretain < ActiveRecord::Base
	belongs_to :user
	belongs_to :report_user,foreign_key: "reporter_id",class_name: "User"
	after_save :send_apply_mail,:if => Proc.new{|r| r.aasm_state_changed? && r.aasm_state=="auditting"} 
	after_save :send_finished_mail,:if => Proc.new{|r| r.aasm_state_changed? && (["acceptting","rejectting"].include? r.aasm_state)} 
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


    def self.report_user
    	User.where(role: [100,200]).select(:id,:name).collect{|u|[u.name,u.id]}   	
    end
    def is_reporter?(user_id)
    	reporter_id==user_id
    end
end
