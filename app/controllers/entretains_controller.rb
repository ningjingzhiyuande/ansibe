class EntretainsController < ApplicationController
  skip_before_action :authenticate_user!,:only => [:auddit_from_mail]
  before_action :set_entretain, only: [:show,:auddit,:auddit_from_mail]

  # GET /entretains
  # GET /entretains.json
  def index
  	if params[:q]=="submit"
  		@entretains = current_user.entretains

  	elsif params[:q]=="report"
        @entretains = current_user.report_entretains
    else
        @entretains = Entretain.where(["user_id=? or reporter_id=?", current_user.id,current_user.id])
    end
  end

  # GET /entretains/1
  # GET /entretains/1.json
  def show
  end

  # GET /entretains/new
  def new
    @entretain = Entretain.new
  end



  # POST /entretains
  # POST /entretains.json
  def create
    @entretain = Entretain.new(entretain_params)
    @entretain.content = params["content"]
    @entretain.user_id = current_user.id
    @entretain.audit if @entretain.reporter_id

    respond_to do |format|
      if @entretain.save
        format.html { redirect_to @entretain, notice: 'Entretain was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entretain }
      else
        format.html { render action: 'new' }
        format.json { render json: @entretain.errors, status: :unprocessable_entity }
      end
    end
  end
  def auddit
  	 @entretain.send(params[:e])

  	 redirect_to entretains_url if  @entretain.save
  end

  def auddit_from_mail
     email =  Base64.decode64(params["token"])
     motion =  Base64.decode64(params["e"])
     user = User.find_by(email: email)
     return :text => "error" unless user 
     return :text => "bushi " if user.id !=  @entretain.reporter_id
     sign_in user  
     @entretain.send(motion)
    redirect_to entretains_url if  @entretain.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entretain
      @entretain = Entretain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entretain_params
      params.require(:entretain).permit(:user_id, :title, :content, :reporter_id,:num,:attache)
    end
end