class Notifier < ActionMailer::Base
  default from: "wenyang@cnpe.cc"
    def new_attendance(user)
      @user = user
    mail :to => @user.email, :subject => 'New Attendance Created'
  end
end

