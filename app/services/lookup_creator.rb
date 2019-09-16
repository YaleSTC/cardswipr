# frozen_string_literal: true

# Service object to create an Lookup
class LookupCreator
  attr_accessor :lookup
  # Initialize an LookupCreator
  #
  # @param search_param [String]
  def initialize(search_param:)
    @search_param = search_param
  end

  def call
    @lookup = PeopleHub::PersonRequest.get(
      PeopleHub::ParamsParser.create_search_hash(@search_param)
    )
    true
  rescue RuntimeError
    false
  end
end
