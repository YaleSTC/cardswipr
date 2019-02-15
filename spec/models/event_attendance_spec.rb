# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventAttendance, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:attendance) }
  end
end
