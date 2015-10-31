== README

This is a web app built for the indoor ultimate frisbee league: FITTFU
Uses
* Score keeping (and fantasy points) during games - *not implemented*
* Hosting Fantasy Leagues - *not implemented*
* Data visualizations based on fantasy data - *not implemented*
* Sending out a spreadsheet or google spreadsheet with data - *not implemented*

Technical Details:
* Ruby version: 2.2.1 (specified in gem file for RVM)
* Rails version: 4.2.4
* Database: Postgres, run the following commands to start (also run on test environment)
  * rake db:reset
  * rake db:migrate
  * To add sample players/teams (do in this order) in lib/tasks
    * rake db:sample_teams
    * rake db:sample_players_data
* Testing: Rspec
  * For command line: rspec spec/file_name:line_number
  * Can run with no arguments to run all tests, do not need a line number, can run on a folder
* Services:
  * none yet
