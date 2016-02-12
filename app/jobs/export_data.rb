class ExportData
  include SuckerPunch::Job

  def perform(token, week)
    p "starting to export"
    ActiveRecord::Base.connection_pool.with_connection do
      # make sure winners have been assigned
      AssignWinners.new.perform
      begin
        OutputWeek.write(token, week)
      rescue => error
        p "ERROR"
        p error.message
      end
    end
    p "finished exporting"
  end
end