FakeApiRunner =
  Capybara::Discoball::Runner.new(FakeApi::Application) do
    FakeApi.base_url = "#{server.host}:#{server.port}"
  end
