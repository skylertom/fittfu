class ChangeGameStatBelongsTo < ActiveRecord::Migration
  def up
    rename_column :game_stats, :team_game_id, :game_id
    reversible do |direction|
      direction.up do
        GameStat.all.find_each { |gs| gs.update_attributes(game_id: TeamGame.find(gs.game_id).game_id) }
      end
      direction.down do
        GameStat.all.find_each { |gs| gs.update_attributes(team_game_id: Game.find(gs.team_game_id).team_game_id) }
      end
    end
  end
end
