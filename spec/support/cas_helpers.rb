# frozen_string_literal: true

# Module to contain CAS stubs for testing
module CASHelpers
  def stub_cas
    url = 'https://cas.cas.cas/users/service?service='\
          'https://cas.cas.cas/users/service&ticket=blah/login'
    filepath = "#{RSPEC_ROOT}/support/fixtures/cas.xml"
    stub_request(:get, url)
      .to_return(status: 200, body: File.read(filepath), headers: {})
  end
end

RSpec.configure do |c|
  c.include CASHelpers
end
