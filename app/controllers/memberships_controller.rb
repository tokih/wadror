class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, only: [:confirm, :create, :new, :update, :delete, :edit, :apply]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  def confirm
    applied_membership = Membership.find(params[:id])
    confirmer_membership = Membership.where("user.id = ? and beer_club_id = ? and confirmed = ?", current_user.id, applied_membership.beer_club_id, true)
    if confirmer_membership
      applied_membership.update_attribute :confirmed, true
      redirect_to beer_club_path applied_membership.beer_club.id, notice: "Membership for #{User.find(applied_membership.user.id).username} confirmed successfully."
    else
      redirect_to beer_club_path applied_membership.beer_club_id, notice: "You need to be a member of this beer club to confirm other applications!"
    end
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @users = User.all
    @beer_clubs = BeerClub.all	
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new params.require(:membership).permit(:beer_club_id, :user_id)

    respond_to do |format|
      if @membership.save
        current_user.memberships << @membership
        format.html { redirect_to beer_club_path(@membership.beer_club), notice: "#{current_user}, your application is now queued for approval" }
        format.json { render action: 'show', status: :created, location: @membership }
      else
        @users = User.all
        @beer_clubs = BeerClub.all
        format.html { render action: 'new' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Membership was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params[:membership]
    end
end
