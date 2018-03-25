class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy]

  # GET /tournaments
  # GET /tournaments.json
  def index
    @tournaments = Tournament.all
  end

  # GET /tournaments/1
  # GET /tournaments/1.json
  def show
    @tournament = Tournament.find(params[:id])
    @tournament.participants.shuffle

    @length = @tournament.participants.length
    @base = 1
    @rounds = 0
    while (@length > @base) do
      @base += @base
      @rounds += 1
    end
    @base /= 2

    @team = []
    @tournament.participants.each do |member|
      @team << member.username
    end

    @match = Match.find_by(joueur1: current_user.username) || Match.find_by(joueur2: current_user.username)
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
  end

  # POST /tournaments
  # POST /tournaments.json
  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.creator = current_user
    @tournament.winners = []

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to @tournament, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tournaments/1
  # PATCH/PUT /tournaments/1.json
  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    if current_user == @tournament.creator
      @tournament.destroy
      respond_to do |format|
        format.html { redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash.now[:error] = "Desole, vous n'etes pas le createur du tournoi."
    end
  end

  def suscribe
    if signed_in?
      @tournament = Tournament.find(params[:id])
      @tournament.participants << current_user
      @tournament.save
      flash[:success] = "Vous êtes inscrit qu tournoi !"
      redirect_to tournaments_path
    else
      falsh[:error] = "Vous devez vous connecter pour vous inscrire au tournoi."
      redirect_to login_path
    end
  end

  def unsuscribe
    @tournament = Tournament.find(params[:id])
    @tournament.participants.delete(current_user)
    @tournament.save
    flash[:success] = "Vous êtes désinscrit."
    redirect_to tournaments_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:title, :description, :date, :pricepool, :creator)
    end
  end
