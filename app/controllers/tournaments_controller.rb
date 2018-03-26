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

    Match.all.find_all{|match| match.tournament == @tournament}.each do |match|
      if match.joueur1 == current_user.username && match.statut && !(match.joueur2.nil?)
        @match = match
      elsif match.joueur2 == current_user.username && match.statut && !(match.joueur1.nil?)
        @match = match
      end
    end
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

    cc = Category.find_by(name: @tournament.game)
    if cc.nil?
      c = Category.new(name: @tournament.game)
      c.save
      @tournament.category = c
    else
      @tournament.category = cc
    end

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
    if current_user == @tournament.creator
      respond_to do |format|
        if @tournament.update(tournament_params)
          format.html { redirect_to @tournament, notice: 'Tournament was successfully updated.' }
          format.json { render :show, status: :ok, location: @tournament }
        else
          format.html { render :edit }
          format.json { render json: @tournament.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = "Vous n'etes pas le createur de ce tournoi."
      redirect_to "/tournaments"
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.json
  def destroy
    if current_user == @tournament.creator
      Match.all.find_all{|match| match.tournament==@tournament}.each do |match|
        match.destroy
      end
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
      if @tournament.participants.length < @tournament.maxPlayers
        @tournament.participants << current_user
        @tournament.participants.all.each do |member|
          member.points = 0
          member.save
        end
        Match.all.find_all{|match| match.tournament == @tournament}.each do |match|
          match.destroy
        end
        @tournament.save
        flash[:success] = "Vous êtes inscrit qu tournoi !"
        redirect_to @tournament
      else
        flash[:danger] = "Le nombre maximum de participants est atteint."
        redirect_to @tournament
      end
    else
      flash[:danger] = "Vous devez vous connecter pour vous inscrire au tournoi."
      redirect_to login_path
    end
  end

  def unsuscribe
    if signed_in?
      @tournament = Tournament.find(params[:id])
      @tournament.participants.all.each do |member|
        member.points = 0
        member.save
      end
      Match.all.find_all{|match| match.tournament == @tournament}.each do |match|
        match.destroy
      end
      @tournament.participants.delete(current_user)
      @tournament.save
      flash[:success] = "Vous êtes désinscrit."
      redirect_to @tournament
    else
      flash[:error] = "Vous devez vous connecter pour vous desinscrire au tournoi."
      redirect_to login_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tournament_params
      params.require(:tournament).permit(:title, :description, :date, :pricepool, :creator, :game, :maxPlayers)
    end
  end
