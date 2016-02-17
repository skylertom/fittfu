class PlayersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @players = Player.includes(:team).all
    @week = Game.past.exists? ? Game.past.first.week : nil
  end

  def new
    authorize Player.new
  end

  def edit
    @player = Player.find_by(id: params[:id])
    authorize @player
    if @player.blank?
      flash[:error] = "Couldn't find this player to edit"
      redirect_to players_path
    end
  end

  def update
    @player = Player.find_by(id: params[:id])
    if @player
      authorize @player
      flash[:alert] = "Warning: If you changed #{@player.name}'s name, please update their name on the Google Doc"
      @player.update(player_params)
      @membership = player.membership
      if @membership && @membership.team_id != params[:membership][:team_id]
        @membership.destroy
        @player.memberships.create(team_id: params[:membership][:team_id])
      end
      redirect_to @player
    else
      flash[:error] = "Couldn't find this player to update"
      redirect_to players_path
    end
  end

  def create
    @player = Player.new(player_params)
    authorize @player
    if @player.save
      if params[:membership][:team_id].blank?
        redirect_to @player
      else
        membership = @player.memberships.create(team_id: params[:membership][:team_id])
        redirect_to team_path(membership.team)
      end
    else
      flash[:error] = "Could not save new player"
      redirect_to new_player_path
    end
  end

  def show
    @player = Player.find_by(id: params[:id])
    if @player.blank?
      flash[:error] = "Couldn't find this player"
      redirect_to players_path
    end
  end

  # TODO edit

  def destroy
    @player = Player.find_by(id: params[:id])
    authorize @player
    if @player
      flash[:alert] = "Deleted #{@player.name}"
      @player.destroy
    else
      flash[:error] = "Could not find player with id: #{params[:id]}"
    end
    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name, :gender)
  end
end
