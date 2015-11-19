require 'spec_helper'
require 'cgi'

class FakeCardSwiprApi
  @template = %q({
    "ServiceResponse": {
      "Record": {
        "Upi": "%{upi}",
        "WorkPhone": "+1 (203) 555-5555",
        "PrimaryAffiliation": "STAFF",
        "EmailAddress": "%{email}",
        "FirstName": "%{first_name}",
        "ProxNumber": "{prox}",
        "KnownAs": "",
        "NetId": "%{netid}",
        "LastName": "%{last_name}",
        "MagStripeNumber": "${mag}"
      }
    }
  })

  @data = [
    { upi: '1', netid: 'willy', first_name: 'Willy', last_name: 'Wonka',
      email: 'willy@example.com', prox: '0000000001', mag: '1000000001' },
    { upi: '2', netid: 'frodo', first_name: 'Frodo', last_name: 'Baggins',
      email: 'frodo@example.com', prox: '0000000002', mag: '1000000002' }
  ]

  def self.call(env)
    params = CGI.parse(env['QUERY_STRING'])
    #puts "FakeCardSwiprApi.call ENV: #{env}"
    #puts "FakeCardSwiprApi.call params: #{params}"

    data = nil
    data = _find_data(:upi, params['upi'][0]) if params['upi'][0]
    data = _find_data(:netid, params['netid'][0]) if params['netid'][0]
    data = _find_data(:email, params['email'][0]) if params['email'][0]
    data = _find_data(:prox, params['proxNumber'][0]) if params['proxNumber'][0]
    data = _find_data(:mag, params['magstripenumber'][0]) if params['magstripenumber'][0]

    if data
      json = @template % data
      return [200, {}, [json]]
    else
      puts "INFO FakeCardSwiprApi.call not found - query: #{params}"
      return [404, {}, ['{}']]
    end
  rescue => e
    puts "ERROR FakeCardSwiprApi.call - #{e}"
  end

  def self._find_data(key, value)
    (@data.select { |x| x[key] == value })[0]
  end
end
