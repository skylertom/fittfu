class ExportData
  @queue = :data_export

  def self.perform(token, week)
    ActiveRecord::Base.clear_active_connections!
    p "starting to export"
    begin
      OutputWeek.write(token, week)
    rescue => error
      p "ERROR"
      p error.message
    end
    p "finished exporting"
  end
end