class GameStatsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @game_stat = GameStat.find_by(id: params["id"])
    authorize @game_stat
    if @game_stat
      @game_stat.update!(permitted_attributes(@game_stat))
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.js { }
      end
    end
  end
end
