# frozen_string_literal: true

# Service object to import Preregistrations from a .csv file
class PreregistrationImporter
  require 'csv'
  attr_accessor :count
  # Initialize a PreregistrationImporter
  #
  # @param event [Event]
  # @param path [PathName]
  def initialize(event:, path:)
    @event = event
    @path = path
    @count = 0 # how many preregistrations were successfully created
  end

  def call
    CSV.foreach(@path, headers: true) do |row|
      creator = PreregistrationCreator.new(event: @event, search_param: row[0])
      @count += 1 if creator.call
    end
    true
  rescue CSV::MalformedCSVError
    false
  end
end
