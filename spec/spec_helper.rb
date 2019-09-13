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
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    # FactoryGirl.lint
    # %x[bundle exec rake assets:precompile]
  end

  config.before(:each) do |example|
    stub_external_requests
  end
  
  config.include Rails.application.routes.url_helpers
end

# Disable all external HTTP requests. Will stub out everything external.
WebMock.disable_net_connect!(allow_localhost: true)

def sign_in(netid)
  CASClient::Frameworks::Rails::Filter.fake(netid)
end

def stub_external_requests
  stub = stub_request(:any, /#{ENV.fetch('ID_API_URL')}/)
  stub.to_rack(FakeCardSwiprApi)

  stub_request(:any, /#{ENV.fetch('SN_INSTANCE')}/)
    .to_return(:status => 200,
      :body => '{ "records": [{ "sys_id" : "made_up_sys_id" }] }')
end