class GamesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:time] == "past"
      @games = Game.past.includes(:teams)
    elsif params[:time] == "upcoming"
      @games = Game.upcoming.includes(:teams)
    elsif params[:time] == "all"
      @games = Game.all.includes(:teams)
    elsif !params[:week].blank?
      @games = Game.where(week: params[:week]).includes(:teams)
    else
      @games = Game.current.includes(:teams)
    end
    authorize @games
  end

  def new
    authorize Game.new
  end

  def create
    @game = Game.new(game_params)
    authorize @game
    if @game.save
      create_team_game(params[:home_team][:team_id])
      create_team_game(params[:away_team][:team_id])
      redirect_to @game
    else
      flash[:error] =  "Error: could not create game"
      redirect_to new_game_path
    end
  end

  def show
    @game = Game.find_by(id: params[:id])
    authorize @game
  end

  def scorekeep
    @game = Game.find_by(id: params[:id])
    authorize @game
  end

  def create_schedule
    authorize Game.new
    if Schedule.for(Time.zone.now.year).any?
      if MakeSchedule.build.call
        redirect_to games_path
      else
        flash[:error] = "Games already created or not enough teams were made yet"
        redirect_to root_path
      end
    else
      flash[:error] = "Please add game times first"
      redirect_to root_path
    end

  end

  # TODO Remove for production
  def delete_all
    Game.destroy_all unless Game.first.blank?
    redirect_to games_path
  end

  def destroy
    @game = Game.find_by(id: params[:id])
    authorize @game
    if @game
      @game.destroy
    else
      flash[:error] = "Could not find game with id: #{params[:id]}"
    end
    redirect_to games_path
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
