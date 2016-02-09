require "google/api_client"
require "google_drive"

class GetPlayersStats
  # updates players game_stats to have as many swag points as fantasy points
  def self.from_google(token)
    session = GoogleDrive.login_with_oauth(token)

    file = session.spreadsheet_by_key("1myvP8Bgdx7plek-gX38GvNVsUztj8EMPY76ckNuax-k")
    teams = Team.all
    teams.each do |t|
      sheet = file.worksheet_by_title(t.captain_tab)
      players = t.players
      y = 2
      gender = Player::EMAN
      while !sheet[y, 1].blank? || gender < Player::EWO do
        if sheet[y, 1].blank?
          gender = Player::EWO
          next
        end
        p = players.find_by(name: sheet[y, 1], gender: gender)
        Schedule.all.size.times do |week|
          week_score = sheet[y, week + 2]
          p.game_stats.find_by(week: week).update_attribute(:swag, week_score) unless p.blank? || week_score.blank? || week_score == 0
        end
        y += 1
      end
      p "finished #{t.name}"
    end
  end
end
