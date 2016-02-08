class AddCaptainNameToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :captain_tab, :string
    add_column :teams, :short_name, :string
    rename_column :team_games, :points, :goals
  end
end
