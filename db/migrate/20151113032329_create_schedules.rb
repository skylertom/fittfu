class CreateSchedules < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :schedules, id: :uuid  do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :year

      t.timestamps null: false
    end

    add_column :games, :time, :timestamp
  end
end
