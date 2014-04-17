class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy, :approve, :reject, :review]


  def index
    @attendances = Attendance.all
   # @applicants = User.all
   # @reviewer1s = Reviewer1.all
  end


  def show
    @applicant = @attendance.applicant#User.find(@attendance.applicant_id)
    @reviewer1 = @attendance.reviewer1 #User.where(@attendance.reviewer1_username)
  end

  def new
    @attendance = Attendance.new
  end

  def edit
  end

  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
       # Notifier.new_attendance(current_user).deliver
        @attendance.submit!

        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attendance }
      else
        format.html { render action: 'new' }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url }
      format.json { head :no_content }
    end
  end


  def approve
    @attendance.accept!
    redirect_to :back, :notice => 'approved successfully!'
  end

  def reject
    @attendance.reject!
    redirect_to :back, :notice => 'rejected successfully!'
  end

  def review
    @attendance.review!
    redirect_to :back, :notice => 'reviewed successfully!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:applicant_id, :reviewer1_username, :reviewer2_id, :workflow_state, :leave_kind, :leave_excuse, :start_at, :end_at)
    end
end
