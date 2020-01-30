# frozen_string_literal: true

module PeopleHub
  # Class for parsing search_param strings passed in by the user
  class ParamsParser
    # Returns a hash {Symbol=>String} that can be passed to PersonRequest.get
    #
    # @param search_params [*String]
    # @return [Hash] key: type of the search param, value: search_param
    def self.create_search_hash(*search_params)
      result = {}
      search_params.each do |search_param|
        key = determine_key(search_param)
        result[key] = search_param
      end
      result
    end

    # @param search_param [String]
    # @return [Symbol]
    def self.determine_key(search_param)
      if search_param.length == 10 && search_param.match?(/^[0-9]{10}$/)
        :proxnumber
      elsif search_param.match?(/[a-z]/)
        :netid
      else
        :invalid_param
      end
    end
  end
end
