class TeamGamesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @team_game = TeamGame.new(team_games_params)
    @team_game.save
    redirect_to :back
  end

  private
  def team_games_params
    params.require(:team_game).permit(:team_id, :game_id)
  end
end
