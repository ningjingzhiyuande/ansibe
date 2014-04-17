class NetCardsController < ApplicationController
  before_action :set_net_card, only: [:show, :edit, :update, :destroy, :approve, :reject, :review]


  def index
    @net_cards = NetCard.all
    @applicants = Applicant.all
    @reviewer1s = Reviewer1.all
  end

  def show
    @applicant = Applicant.find(@net_card.applicant_id)
    @reviewer1 = Reviewer1.find_by_username(@net_card.reviewer1_username)
  end

  def new
    @net_card = NetCard.new
  end


  def edit
  end


  def create
    @net_card = NetCard.new(net_card_params)

    respond_to do |format|
      if @net_card.save
        @net_card.submit!
        format.html { redirect_to @net_card, notice: 'Net card was successfully created.' }
        format.json { render action: 'show', status: :created, location: @net_card }
      else
        format.html { render action: 'new' }
        format.json { render json: @net_card.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @net_card.update(net_card_params)
        format.html { redirect_to @net_card, notice: 'Net card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @net_card.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @net_card.destroy
    respond_to do |format|
      format.html { redirect_to net_cards_url }
      format.json { head :no_content }
    end
  end


  def approve
    @net_card.accept!
    redirect_to :back, :notice => 'approved successfully!'
  end

  def reject
    @net_card.reject!
    redirect_to :back, :notice => 'rejected successfully!'
  end

  def review
    @net_card.review!
    redirect_to :back, :notice => 'reviewed successfully!'    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_net_card
      @net_card = NetCard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def net_card_params
      params.require(:net_card).permit(:applicant_id, :reviewer1_username, :reviewer2_username, :workflow_state, :request_excuse, :start_at, :end_at)
    end
end
