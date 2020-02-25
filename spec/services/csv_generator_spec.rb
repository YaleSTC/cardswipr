# frozen_string_literal: true

require 'rails_helper'

# Adapted from Vesta
RSpec.describe CsvGenerator do
  let(:data) { build_list(:attendance, 5) }
  let(:generator) { described_class.new(data: data) }

  context 'when valid data is passed' do
    it 'returns true' do
      expect(generator.generate).to eq(true)
    end

    it 'creates a csv successfully' do
      generator.generate
      result = generator.csv
      export = "first_name,last_name,email,net_id,upi,checked_in_at\n" +
               data.map { |n| export_row_for(n) }.join
      expect(result).to eq(export)
    end
  end

  context 'when no data is passed' do
    it 'returns false' do
      result = described_class.new(data: []).generate
      expect(result).to eq(false)
    end
  end

  def export_row_for(attendance)
    [attendance.first_name, attendance.last_name, attendance.email,
     attendance.net_id, attendance.upi, attendance.checked_in_at]
      .join(',') + "\n"
  end
end
