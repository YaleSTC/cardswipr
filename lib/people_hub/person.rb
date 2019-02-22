# frozen_string_literal: true

# Module that requests information on a person from the Identity API,
# parses the data and stores the required data as an object.
module PeopleHub
  # Class for PeopleHub::Person object. This object stores relevant
  # information retrieved from the specified Identity API and provides
  # methods to parse through the full hash returned by the API.
  # It is currently configured to parse a hash with the structure
  # of the response from Yale's PeopleHub API. Please edit the parsing
  # methods to make this work with other API responses.
  class Person
    attr_reader :first_name, :last_name, :net_id, :upi, :email, :phone

    # Initialize a PeopleHub::Person object
    #
    # @param full_hash [Hash] a full hash of the api response
    def initialize(**params)
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @email = params[:email]
      @net_id = params[:net_id]
      @upi = params[:upi]
      @phone = params[:phone]
    end

    # Create a PeopleHub::Person object from a full hash
    #
    # @param full_hash [Hash] a full hash of a single person
    def self.create_person(full_hash:)
      filtered_hash = parse_all_params(full_hash)
      new(**filtered_hash)
    end

    # Parses a full hash to create a filtered hash with
    # required attributes only.
    #
    # @param full_hash [Hash] a full hash of a single person
    def self.parse_all_params(full_hash)
      { first_name: parse_first_name(full_hash),
        last_name: parse_last_name(full_hash), email: parse_email(full_hash),
        net_id: parse_net_id(full_hash), upi: parse_upi(full_hash),
        phone: parse_phone(full_hash) }
    end

    def self.parse_first_name(full_hash)
      full_hash['Names']['ReportingNm']['First']
    end

    def self.parse_last_name(full_hash)
      full_hash['Names']['ReportingNm']['Last']
    end

    def self.parse_email(full_hash)
      full_hash['Contacts']['Email']
    end

    def self.parse_net_id(full_hash)
      full_hash['Identifiers']['NETID']
    end

    def self.parse_upi(full_hash)
      full_hash['Identifiers']['UPI']
    end

    def self.parse_phone(full_hash)
      full_hash['Contacts']['WPhone']
    end
    private_class_method :parse_all_params, :parse_first_name, :parse_last_name,
                         :parse_email, :parse_net_id, :parse_upi, :parse_phone
  end
end
