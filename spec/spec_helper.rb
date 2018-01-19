ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require_relative('support/database_cleaner.rb')
require_relative('support/fake_cardswipr_api')

ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

require 'rspec'
require 'capybara/rails'
require 'casclient'
require 'casclient/frameworks/rails/filter'
require 'webmock/rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Capybara::DSL
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    # FactoryBot.lint
    # %x[bundle exec rake assets:precompile]
  end

  config.before(:each) do |example|
    stub_external_requests
  end
  
  Capybara.asset_host = 'http://localhost:3000'
  Capybara.default_driver = :selenium
  Capybara.default_wait_time = 5
  config.include Rails.application.routes.url_helpers
end

# Disable all external HTTP requests. Will stub out everything external.
WebMock.disable_net_connect!(allow_localhost: true)

def sign_in(netid)
  CASClient::Frameworks::Rails::Filter.fake(netid)
end

def stub_external_requests
  stub = stub_request(:any, /soa-gateway\/cardswipr\/people\/data/)
  stub.to_rack(FakeCardSwiprApi)

  stub_request(:any, /yale.service-now.com/)
    .to_return(:status => 200,
      :body => '{ "records": [{ "sys_id" : "made_up_sys_id" }] }')
end
