# frozen_string_literal: true

# Module that requests information on a person from the Identity API,
# parses the data and stores the required data as an object.
module PeopleHub
  # Class for sending and parsing a request to the PeopleHub::Querier.
  # Provides the get method to interact with the Querier and
  # return a PeopleHub::Person object with the required params.
  class PersonRequest
    # Takes a single paramenter and gets a response from the identity
    # server from the url in the env file. Calls response_to_person to return
    # a PeopleHub::Person object. If the fake_peoplehub env is set to true
    # it will return a fake person.
    #
    # @param params [String] a dictionary of params
    def self.get(search_param)
      raise 'Invalid Input' if search_param.blank?

      # take only the first part of the string until there is a non-word char
      first_match = search_param.match(/\w+\W{0}/)[0]
      query_peoplehub(first_match)
    end

    # Determines which parameter type the string probably is and
    # then sends it to the Querier. Returns a PeopleHub::Person.
    # Will return a fake person if the fake_peoplehub env is set to true.
    #
    # @param search_param [String] the search param used to find the person
    # rubocop:disable Metrics/MethodLength
    def self.query_peoplehub(search_param)
      if search_param.length == 10 && search_param.match?(/^[0-9]{10}$/)
        begin
          response_to_person(PeopleHub::Querier.get(proxnumber: search_param))
        rescue RuntimeError
          response_to_person(PeopleHub::Querier.get(idcard: search_param))
        end
      elsif search_param.match?(/[a-z]/)
        response_to_person(PeopleHub::Querier.get(netid: search_param))
      else
        raise 'Invalid Input'
      end
    end
    # rubocop:enable Metrics/MethodLength

    # Convert response from identity server to PeopleHub::Person object.
    # Will return a fake person if the fake_peoplehub env is set to true.
    #
    # @param response [#to_h] a JSON response to be turned into a hash
    def self.response_to_person(response)
      if Rails.configuration.fake_peoplehub
        return PeopleHub::FakePerson.new(response)
      end

      person_hash = response.parsed_response&.dig('People', 'Person')
      raise 'Person not found' if person_hash.nil?

      PeopleHub::Person.create_person(full_hash: person_hash)
    end

    private_class_method :response_to_person, :query_peoplehub
  end
end
