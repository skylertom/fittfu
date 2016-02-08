require "google/api_client"
require "google_drive"

class GetPlayersStats
  # updates players game_stats to have as many swag points as fantasy points for week x
  def self.write(token, week)
    session = GoogleDrive.login_with_oauth(token)

    file = session.spreadsheet_by_key("1myvP8Bgdx7plek-gX38GvNVsUztj8EMPY76ckNuax-k")
    #coordinate system starts at 1
    teams = Team.all
    teams.each do |t|
      sheet = file.worksheet_by_title(t.captain_tab)
      players = t.players
      y = 2
      gender = Player::EMAN
      while !sheet[y, 1].blank? || gender < Player::EWO do
        gender = Player::EWO if sheet[y, 1].blank?
        p = players.find_by(name: sheet[y, 1], gender: gender)
        players.game_stats.find_by(week: week).update_attribute(:swag, sheet[y, week + 1 + 1]) unless p.blank?
        y += 1
      end
      p "finished #{t.name}"
    end
  end
end
