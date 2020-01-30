# frozen_string_literal: true

require 'httparty'
require 'uri'

module PeopleHub
  # Class to directly query the PeopleHub API. Provides a get method that
  # returns the response from the API and raises an exception if it receives a
  # non-200 response.
  class Querier
    AUTH = { username: ENV['IDENTITY_SERVER_USERNAME'],
             password: ENV['IDENTITY_SERVER_PASSWORD'] }.freeze

    BASE = ENV['IDENTITY_SERVER_URL']

    VALID_PARAMS =
      %i(netid upi firstname lastname idcard proxnumber role).freeze

    # Method to take a hash of params and directly query PeopleHub.
    # Returns a JSON PeopleHub response. Will not send a query if
    # the fake_peoplehub env is set to true
    #
    # @param params [Hash] a hash of params
    def self.get(params)
      return nil if Rails.configuration.fake_peoplehub

      url = BASE + '?outputformat=json&' + parse_params(params)
      response = HTTParty.get(url, basic_auth: AUTH)
      return response unless response.code != 200

      raise "Error code #{response.code} returned from #{BASE}"
    end

    # Parse params to check if they are valid and to join them to the url
    #
    # @param params [Hash] a hash of params
    def self.parse_params(params)
      url_request = []
      params.each do |param, value|
        exception = "#{param} is not a valid parameter for searching for person"
        raise exception unless VALID_PARAMS.include?(param)

        url_request.append "#{param}=#{value}"
      end
      url_request.join('&')
    end

    private_class_method :parse_params
  end
end
