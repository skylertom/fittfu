class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
  end

  def create
    @team = Team.new(team_params)
    @team.save
    redirect_to @team
  end

  def show
    @team = Team.find_by(id: params[:id])
  end

  def destroy
    @team = Team.find_by(id: params[:id])
    if @team
      @team.destroy
    else
      flash[:error] = "Could not find team with id: #{params[:id]}"
    end
    redirect_to teams_path
  end

  private

    def team_params
      params.require(:team).permit(:name, :color)
    end
end
