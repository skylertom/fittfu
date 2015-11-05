class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
  end

  def create
    @game = Game.new(game_params)
    p params[:home_team][:team_id]
    if @game.save
      create_team_game(params[:home_team][:team_id])
      create_team_game(params[:away_team][:team_id])
      redirect_to @game
    else
      p "Error: could not create game"
    end
  end

  def show
    @game = Game.find_by(id: params[:id])
  end

  private

  def create_team_game(team_id)
    team_game = @game.team_games.build(team_id: team_id)
    if team_game.save
      return true
    else
      p "Error: could not create team_game"
      return false
    end
  end

  def game_params
    params.require(:game).permit(:week, :time_slot)
  end
end
