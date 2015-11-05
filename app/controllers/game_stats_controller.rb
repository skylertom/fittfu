class GameStatsController < ApplicationController
  def update
    @game_stat = GameStat.find_by(id: params["id"])
    if @game_stat
      @game_stat.update!(game_stat_params)
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.js { }
      end
    end
  end

  private
    def game_stat_params
      params.require(:game_stat).permit(:ds, :goals, :assists, :turns)
    end
end
