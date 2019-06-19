require 'capybara_discoball'

FakeApiRunner =
  Capybara::Discoball::Runner.new(FakeApi::Application) do |server|
    FakeApi.base_url = "#{server.host}:#{server.port}"
  end
