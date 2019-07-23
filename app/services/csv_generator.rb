# frozen_string_literal: true

require 'csv'

# Service object to create csvs for export.
# Will parse the passed relation for information and add it to a csv which
# it will return.
#
# Adapted from Vesta.
class CSVGenerator
  include ActiveModel::Model

  validates :data,
            presence: { message: 'must exist before it can be exported.' }

  # Initialize a new CSVGenerator
  #
  # @param data [Attendance::ActiveRecord_Relation] The data to export.
  def initialize(data:)
    @data = data
  end

  # Generate a CSV
  # The csv is stored in the class' @csv instance variable
  # @return [Boolean] True if the csv generation was successfull and false
  # otherwise
  def generate
    return false unless valid?

    generate_csv_file
    true
  end

  attr_reader :data, :csv

  private

  def generate_csv_file
    attributes = %i(first_name last_name email net_id upi check_in)
    @csv = CSV.generate do |c|
      c << attributes.map(&:to_s)
      data.each do |object|
        c << attributes.map { |a| object.send(a) }
      end
    end
  end
end
