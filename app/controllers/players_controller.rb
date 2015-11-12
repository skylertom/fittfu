class PlayersController < ApplicationController
  def index
    @players = Player.includes(:team).all
  end

  def new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      @player.memberships.create(team_id: params[:membership][:team_id]) unless params[:membership][:team_id].blank?
    end
    redirect_to new_player_path
    #should enable show after create after the draft for sparse player addition
    #redirect_to @player
  end

  def show
    @player = Player.find_by(id: params[:id])
  end

  # TODO edit

  private

  def player_params
    params.require(:player).permit(:name, :gender)
  end
end
