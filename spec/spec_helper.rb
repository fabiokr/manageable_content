ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'shoulda-matchers'
require 'factory_girl'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

FactoryGirl.definition_file_paths = [File.join(ENGINE_RAILS_ROOT, 'spec', 'factories')]
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include Factory::Syntax::Methods
  config.include Capybara::DSL, :example_group => { :file_path => /\bspec\/integration\// }

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end