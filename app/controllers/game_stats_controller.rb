class GameStatsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @game_stat = GameStat.find_by(id: params["id"])
    authorize @game_stat
    if @game_stat
      change = params[:op] == "add" ? 1 : -1
      @game_stat.update_attribute(params[:attr], @game_stat[params[:attr]] + change)
    end
    render 'layouts/_flash_messages'
  end
end
