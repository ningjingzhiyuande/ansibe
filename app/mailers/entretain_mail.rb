class EntretainMail < ActionMailer::Base
  default from: "cgboa@cnpe.cc"
 # @url="http://localhost:5000"

  def send_apply_mail(entretain)
  	@url="http://cgboffice.cnpe.cc"
  	  @entretain = entretain
      mail to: entretain.report_user.try(:email), subject: entretain.user.try(:name)+"用餐申请单,请您审阅"
  end

  def send_finished_mail(entretain)
  	@entretain = entretain
  	@url="http://cgboffice.cnpe.cc"
    mail to: entretain.user.try(:email), subject: entretain.user.try(:name)+"宴请单已被批阅"
  end

  def send_superior_mail(entretain)
	@entretain = entretain
	@url="http://cgboffice.cnpe.cc"
	
    mail to: entretain.last_report_user.try(:email), subject: entretain.user.try(:name)+"宴请单已被#{entretain.report_user.try(:name)}批阅,请您最终审批"
  end


end
