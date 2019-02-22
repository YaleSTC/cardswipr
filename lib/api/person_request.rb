# frozen_string_literal: true

require 'httparty'
require 'uri'

# PersonRequest provides fetch, an easy interface with an identity API
class PersonRequest
  VALID_PARAMS =
    %i(netid upi firstname lastname idcard proxnumber role outputformat).freeze

  # Takes a base url, and a dictionary of params, and fetches a response from
  # the identity server at url. Returns a Person hash, defined in fixtures/
  # success.json.
  def self.fetch(base, params)
    url = base + '?' + parse_params(params)
    response = HTTParty.get(url)

    if response.response.code != 200
      raise "Error code #{response.response.code} returned from #{base}"
    end

    response_to_person(response)
  end

  def self.parse_params(params)
    url_request = []
    params.each do |param, value|
      exception = "#{param} is not a valid parameter for fetching person data"
      raise exception unless param_valid?(param)

      url_request.append "#{param}=#{value}"
    end
    url_request.join('&')
  end

  # convert response from identity server to Ruby hash
  def self.response_to_person(response)
    person = response.parsed_response['People']['Person']
    raise 'Person not found' if person.nil?

    person
  end

  def self.param_valid?(param)
    VALID_PARAMS.include?(param)
  end

  private_class_method :param_valid?, :parse_params, :response_to_person
end
