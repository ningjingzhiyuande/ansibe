class Entretain < ActiveRecord::Base
	belongs_to :user
	belongs_to :report_user,foreign_key: "reporter_id",class_name: "User"
	belongs_to :last_report_user,foreign_key: "last_reporter_id",class_name: "User"
	after_save :send_apply_mail,:if => Proc.new{|r| r.aasm_state_changed? && r.aasm_state=="auditting"} 
	#after_save :chief_report
	after_save :send_superior_mail,:if => Proc.new{|r| r.aasm_state_changed? && r.aasm_state=="acceptting"} 
	
	after_save :send_finished_mail,:if => Proc.new{|r| r.aasm_state_changed? && (["last_acceptting","rejectting","last_rejectting"].include? r.aasm_state)} 
  
  #include SimpleEnum
  #has_enum :titles ,:enums => [[:fuqing12, "1", "福清12"],[:fuqing34, "2", "福清34"],[:fuqing56, "3", "福清56"], \
     #     [:fangjiashan, "4", "方家山"],[:hainan, "5", "海南"],[:tianwan34, "6", "田湾34"],[:xudapu, "7", "徐大堡"],\
     #     [:baeryi, "8", "821"],[:others, "9", "其他"]], :column => :title, :default => :fuqing12
  #has_enum :locations, :enums => [[:xiangechun, 1, "湘鄂春"], [:lingdian, 2 , "零点餐厅"],\
      #   [:others, 3, "其他"]], :column => :location, :default => :xiangechun
  TITLE=['福清12','福清34','福清56','方家山','海南','田湾34','徐大堡','821']
  LOCATION= ['湘鄂春','零点餐厅']
  include AASM
	mount_uploader :attache, AttacheUploader
	aasm do # default column: aasm_state
      state :applying, :initial => true
      state :auditting
      state :acceptting
      state :rejectting

      state :last_acceptting
      state :last_rejectting
      state :finished
    
      event :audit do
         transitions :from => :applying, :to => :auditting#, :guard => :send_apply_mail
      end
      event :accept do
      	 transitions :from => :auditting, :to => :acceptting#, :guard => :send_superior_mail
      end
      event :reject do
      	 transitions :from => :auditting, :to => :rejectting#, :guard => :send_finished_mail
      end
      event :last_accept do
      	 transitions :from => :acceptting, :to => :last_acceptting#, :guard => :send_finished_mail
      end
      event :last_reject do
      	 transitions :from => :acceptting, :to => :last_rejectting#, :guard => :send_finished_mail
      end
      event :finish  do
        transitions :from => [:rejectting,:last_acceptting,:last_rejectting], :to => :finished
      end


    end
    def set_state
    	self.audit! if aasm_state=="applying" && !reporter_id.blank?
    end

    def chief_report
    	#if reporter_id

    end

    def has_approved
    	aasm_state=="acceptting"
    end

    def send_apply_mail
    	#binding.pry
    	EntretainMail.send_apply_mail(self).deliver
    end
    def send_superior_mail
    	EntretainMail.send_superior_mail(self).deliver
    end
    def send_finished_mail
    	EntretainMail.send_finished_mail(self).deliver
    end


    def self.report_user(user)
    	User.where(role: 100).where(department: [user.department, 6100]).select(:id,:name).collect{|u|[u.name,u.id]}   	
    end
    def is_reporter?(user_id)
    	reporter_id==user_id
    end


    def self.last_report_user(user)
      User.where(role: 200).select(:id,:name).collect{|u|[u.name,u.id]}    
    end
    def is_last_reporter?(user_id)
      last_reporter_id==user_id
    end

end
