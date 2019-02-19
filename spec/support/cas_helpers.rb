# frozen_string_literal: true

# Module to contain CAS stubs for testing
module CASHelpers
  def stub_cas(username)
    url = 'https://cas.cas.cas/users/service?service='\
          'https://cas.cas.cas/users/service&ticket=blah/login'
    filepath = "#{RSPEC_ROOT}/support/fixtures/cas.xml"
    modified = replace_net_id(username, filepath)
    stub_request(:get, url)
      .to_return(status: 200, body: modified, headers: {})
  end

  def replace_net_id(username, filepath)
    xml = File.read(filepath)
    doc = Nokogiri::XML(xml)
    cas_user = doc.at_xpath 'cas:serviceResponse/cas:authenticationSuccess/'\
    'cas:user'
    cas_user.content = username

    doc.to_xml
  end
end

RSpec.configure do |c|
  c.include CASHelpers
end
