# frozen_string_literal: true

require 'httparty'
require 'uri'

# Module that requests information on a person from the Identity API,
# parses the data and stores the required data as an object.
module PeopleHub
  # Class for sending and parsing a request to the Identity API.
  # Provides the get method to interact with the identity api and
  # return a PeopleHub::Person object with the required params.
  class PersonRequest
    VALID_PARAMS =
      %i(netid upi firstname lastname idcard proxnumber role).freeze

    # Takes a dictionary of params, and gets a response from the identity
    # server from the url in the env file. Calls response_to_person to return
    # a PeopleHub::Person object.
    #
    # @param params [Hash] a dictionary of params
    def self.get(params)
      base = ENV['IDENTITY_SERVER_URL']
      url = base + '?outputformat=json&' + parse_params(params)
      auth = { username: ENV['IDENTITY_SERVER_USERNAME'],
               password: ENV['IDENTITY_SERVER_PASSWORD'] }
      response = HTTParty.get(url, basic_auth: auth)
      if response.code != 200
        raise "Error code #{response.code} returned from #{base}"
      end

      response_to_person(response)
    end

    # Parse params to check if they are valid and to join them to the url
    #
    # @param params [Hash] a hash of params
    def self.parse_params(params)
      url_request = []
      params.each do |param, value|
        exception = "#{param} is not a valid parameter for searching for person"
        raise exception unless param_valid?(param)

        url_request.append "#{param}=#{value}"
      end
      url_request.join('&')
    end

    # Convert response from identity server to PeopleHub::Person object
    #
    # @param response [#to_h] a JSON response to be turned into a hash
    def self.response_to_person(response)
      person_hash = response.parsed_response['People']['Person']
      raise 'Person not found' if person_hash.nil?

      PeopleHub::Person.create_person(full_hash: person_hash)
    end

    # Check if param is in the list of valid params to search the API with
    #
    # @param param [ActionController::Parameters] a param object
    def self.param_valid?(param)
      VALID_PARAMS.include?(param)
    end

    private_class_method :param_valid?, :parse_params, :response_to_person
  end
end
