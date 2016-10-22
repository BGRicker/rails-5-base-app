source 'https://rubygems.org'
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0'
# Use postgresql as the database Active Record
gem 'pg', '~> 0.19'
gem 'pg_search' #Add postgres-native full text search capability to ActiveRecord

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.2'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'font_assets'
gem 'ionicons-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'kaminari'
gem 'pundit'
gem 'carrierwave'
gem 'fog', '~> 1.20', require: 'fog/aws/storage' #cloud storage
gem 'paper_trail', '~> 5.2'

gem 'singleton-rails', github: 'ldstudios/singleton-rails' #Singleton Admin Settings

#quick page loads
gem 'turbolinks'

gem 'friendly_id'

gem 'thin' #required by Heroku and Procfile

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#Forms
gem "cocoon"
gem 'simple_form'

gem 'slim-rails'
gem 'devise', '~> 4.2.0' #Authentication

gem 'aasm'
gem 'aws-sdk', '~> 2' #Import files from S3
gem 'sidekiq'
gem 'sinatra', require: false #Sidekiq Web needs this

#gem 'activemodel-serializers-xml', github: 'rails/activemodel-serializers-xml' #Needed for draper
gem 'draper', '~> 3.0.0.pre1' #presenters

gem 'foreman' #process management both locally and in production
gem 'attr_encrypted' #Provides encryption for ActiveRecord fields

group :development do
  gem 'rails-erd' #ERD Diagram generator
  gem 'railroady', git: 'git://github.com/preston/railroady.git', branch: 'master'
  gem 'web-console'
  gem 'tddium' #Continuous Integration w/ Solano
  gem 'bullet', '~> 5.3'
end

group :development, :test do
  gem "factory_girl_rails"
  gem 'annotate', '~> 2.6.6' #Annotate schema at the top of ActiveRecord objects - really helpful since this app uses SQL Schema Dump
  gem "awesome_print" # adds style to pry print out- we can remove this one if its too different for anyone
  gem 'forgery' # Test data factory

  gem 'pry-rails' # Debugging
  gem 'pry-byebug' # adds step, next, finish, continue, and breakpoint commands to pry
  gem 'pry-rescue' # run your server with rescue to open pry on any error 'bundle exec rescue rails s'
  gem "pry-stack_explorer" #adds up, down, frame, and show-stack to pry commands
  gem 'dotenv-rails' #Environmental Variable management - see /.env
  gem 'mailcatcher' #development SMTP server - runs in Procfile
  # Access an IRB console on exception pages or by using <%= console %> in views

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :staging do
  gem 'rack-mini-profiler'
end

group :test do
  gem 'rspec-activejob'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'webmock'
  gem 'vcr'
  gem 'rspec'
  gem 'capybara'
  gem 'cucumber'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'launchy' # `save_and_open_page` in integration specs
  gem "rspec-sidekiq" #Mocks Sidekiq interface in Rspec tests
  gem 'simplecov'
  gem 'timecop' #System clock mocking
  gem 'email_spec' # Rspec Matchers for ActionMailer specs
end
group :production, :staging do
  gem 'exception_notification' #Exception emails
  gem 'newrelic_rpm'
  gem 'rails_12factor' #required by Heroku
end
