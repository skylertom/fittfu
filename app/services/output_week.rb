require "google/api_client"
require "google_drive"

class OutputWeek
  def self.write(token, week)
    session = GoogleDrive.login_with_oauth(token)

    file = session.spreadsheet_by_key("1myvP8Bgdx7plek-gX38GvNVsUztj8EMPY76ckNuax-k")
    ws = file.worksheets[0]
    #the coordinate system starts at 1
    #ws[2, 2] = "foo"
    #ws.save
    # it worked!
  end
end