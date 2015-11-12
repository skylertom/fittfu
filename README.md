## FITTFU Readme

This is a web app built for the indoor ultimate frisbee league: FITTFU
Uses
* Score keeping (and fantasy points) during games
* Hosting Fantasy Leagues
* Data visualizations based on fantasy data
* Sending out a spreadsheet or google spreadsheet with data

Technical Details:
* Ruby version: 2.2.1 (specified in gem file for RVM)
* Rails version: 4.2.4
* Database: Postgres
  * run the following commands to start (also run on test environment)
    ```bash
     $ rake db:schema:load
    ```
  * To add sample players/teams (do in this order) in lib/task: 
    ```bash 
     $ rake db:seed
    ```
* Development:
  * To use redis (and resque) install foreman gem and run:
    ```bash
     $ redis-server
    ```
    ```bash
     $ foreman start
    ```
* Testing: Rspec
  * Files located in spec/
  * To run all tests
    ```bash
     $ rspec 
    ```
  * To run on a folder
    ```bash
     $ rspec spec/controllers
    ```
  * To run on a file
  	```bash
     $ rspec spec/controllers/games_controller_spec.rb
    ```    
  * To run a specific test or suite of tests in a file on line 15
 	```bash
     $ rspec spec/controllers/games_controller_spec.rb:15
    ```
* Services:
  * none yet
