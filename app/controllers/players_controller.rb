class PlayersController < ApplicationController
  def index
    @players = Player.includes(:team).all
  end

  def new
    authorize Player.new
  end

  def create
    @player = Player.new(player_params)
    authorize @player
    if @player.save
      if params[:membership][:team_id].blank?
        redirect_to @player
      else
        binding.pry
        membership = @player.memberships.create(team_id: params[:membership][:team_id])
        redirect_to team_path(membership.team)
      end
    else
      redirect_to new_player_path
    end
  end

  def show
    @player = Player.find_by(id: params[:id])
  end

  # TODO edit

  def destroy
    @player = Player.find_by(id: params[:id])
    authorize @player
    if @player
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
