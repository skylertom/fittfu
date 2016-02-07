require 'resque/tasks'
require 'redis'

task "resque:setup" => :environment do
  ENV['QUEUE'] = "*"
end

task "jobs:work" => "resque:work"