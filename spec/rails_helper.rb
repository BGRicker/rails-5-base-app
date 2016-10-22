require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'webmock/rspec'
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/dsl'
require 'pundit/rspec'
require 'rspec/active_job'
require 'rspec/expectations'
require 'rspec/collection_matchers'
require 'aasm/rspec'
require 'devise'
include ActionDispatch::TestProcess



# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers



  config.render_views

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    Capybara.javascript_driver = :webkit
    Capybara.default_wait_time = 2
  end

  config.after(:suite) do
    # Use FileUtils class to delete temp files created by the test suite
    # http://www.ruby-doc.org/stdlib-2.2.0/libdoc/fileutils/rdoc/FileUtils.html
    FileUtils.rm_f(Dir.glob(File.join(Rails.root, 'tmp', '*.pdf')))
    FileUtils.rm_rf(File.join(Rails.root, 'tmp', 'uploads'))
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:example) do
    Sidekiq::Worker.clear_all
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:example, type: :feature) do
    # :rack_test driver's Rack app under test shares database connection
    # with the specs, so we can use transaction strategy for speed.
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    if driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :transaction
    else
      # Non-:rack_test driver is probably a driver for a JavaScript browser
      # with a Rack app under test that does *not* share a database 
      # connection with the specs, so we must use truncation strategy.
      DatabaseCleaner.strategy = :truncation
    end
  end

  #Stub out sunspot sessions
  config.before(:each) do
    ::Sunspot.session = ::Sunspot::Rails::StubSessionProxy.new(::Sunspot.session)
  end

  config.after(:each) do
    ::Sunspot.session = ::Sunspot.session.original_session
  end

  config.before(:example) do
    DatabaseCleaner.start
  end

  config.after(:example) do
    DatabaseCleaner.clean
  end

  config.append_after(:example) do
    DatabaseCleaner.clean
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

#TODO - EVERYTHING BELOW HERE NEEDS TO BE MOVED INTO SPEC/SUPPORT MODULES AND INCLUDED IN THE CONFIG BLOCK ABOVE
def last_email_queued
  ActionMailer::Base.deliveries.last
end

def sign_in_as_admin(admin)
  visit new_admin_session_path
  fill_in 'Email', with: admin.email
  fill_in 'Password', with: 'test1234'
  click_button 'Log in'
end

def enqueued_jobs
  ActiveJob::Base.queue_adapter.enqueued_jobs
end

def ensure_tmp_files_closed_after_spec(filename_includes)
  ObjectSpace.each_object(Tempfile) do |f|
    if f.path.include? filename_includes
      f.unlink unless f.closed?
    end
  end
end
