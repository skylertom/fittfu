require "google/api_client"
require "google_drive"

class GetPlayers
  def self.from_google(token)
    session = GoogleDrive.login_with_oauth(token)
    file = session.spreadsheet_by_key("1myvP8Bgdx7plek-gX38GvNVsUztj8EMPY76ckNuax-k")
    Team.all.each do |team|
      sheet = file.worksheet_by_title(team.captain_tab)
      if sheet.blank?
        p "Could not find spreadsheet tab for #{captain_tab_name}"
        next
      end
      y = 2
      gender = Player::EMAN
      while !sheet[y, 1].blank? || gender < Player::EWO do
        gender = Player::EWO if sheet[y, 1].blank?
        p = Player.create(name: sheet[y, 1], gender: gender)
        team.memberships.create(player_id: p.id) unless p.blank?
        y += 1
      end
    end
  end
end