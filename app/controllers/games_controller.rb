class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
  end

  # TODO create redirect case when game doesn't save
  def create
    @game = Game.new(game_params)
    if @game.save
      create_team_game(params[:home_team][:team_id])
      create_team_game(params[:away_team][:team_id])
    else
      p "Error: could not create game"
    end
    redirect_to @game
  end

  def show
    @game = Game.find_by(id: params[:id])
  end

  def create_schedule
    unless MakeSchedule.build.call(7)
      flash[:error] = "Games already created or not enough teams were made yet"
    end
    redirect_to action: :index
  end

  def delete_all
    Game.destroy_all unless Game.first.blank?
    redirect_to action: :index
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
