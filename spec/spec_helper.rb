ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

require 'rspec'
require 'capybara/rails'
require 'casclient'
require 'casclient/frameworks/rails/filter'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    # FactoryGirl.lint
    # %x[bundle exec rake assets:precompile]
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  Capybara.asset_host = 'http://localhost:3000'
  config.include Rails.application.routes.url_helpers
end

def sign_in(netid)
  CASClient::Frameworks::Rails::Filter.fake(netid)
end
