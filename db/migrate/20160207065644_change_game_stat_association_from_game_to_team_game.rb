class ChangeGameStatAssociationFromGameToTeamGame < ActiveRecord::Migration
  def up
    add_column :game_stats, :team_game_id, :uuid
    GameStat.all.each do |stat|
      team_id = stat.player.team.id
      game_id = stat.game_id
      stat.update_attribute(:team_game_id, TeamGame.find_by(team_id: team_id, game_id: game_id).id)
    end
    remove_column :game_stats, :game_id, :uuid
  end
  def down
    add_column :game_stats, :game_id, :uuid
    GameStat.all.each do |stat|
      stat.update_attribute(:game_id, stat.team_game.game.id)
    end
    remove_column :game_stats, :team_game_id, :uuid
  end
end
