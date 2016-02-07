source 'https://rubygems.org'
ruby '2.2.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
gem 'pg', '0.18.3'
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails', '~> 4.0.5'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
# For faster mass inserts
gem 'activerecord-import', '~> 0.10.0', require: false
gem 'redis', '3.2.1'
gem 'rack-timeout', '0.3.2'
gem 'devise'
group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end
gem 'pundit'
# version 0.9 just came out Jan 2016 and is not backwards compatible
gem 'google-api-client', '< 0.9'
gem 'google_drive', '1.0.1'
gem 'resque', '~> 1.25.2'

group :production do
  gem 'puma', '2.14.0'
  gem 'rails_12factor'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'
  gem 'dotenv-rails'
  # type ap before model in rails c to get pretty rendering
  gem 'awesome_print', require:'ap'
  gem 'brakeman', require: false
  gem 'codesake-dawn', require: false
  gem 'foreman'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'rails-footnotes', '~> 4.0'
  # Rails tab in Google Chrome inspector (needs Rails panel chrome extension)
  gem 'meta_request', '~> 0.3.4'
  # Better error pages
  gem 'better_errors', '~> 2.1.1'
  # better asset requests in the server log
  gem 'quiet_assets', ' ~> 1.1.0'
  # tells you query times in top right
  gem 'rack-mini-profiler'
end

