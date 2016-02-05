module GamesHelper
  # determines whether the current games view is selected
  def games_range(time_range)
    if params[:time] == time_range || (params[:time].blank? && time_range == "current")
      'active'
    else
      ''
    end
  end
end
