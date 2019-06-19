require 'sinatra/base'
require 'capybara_discoball'

module FakeApi
  class Application < Sinatra::Base
    get "./spec/fixtures/api/success.json" do
      response
    end
  end
end
