# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe 'basic validation' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:net_id) }
    it { is_expected.to validate_presence_of(:upi) }
    it { is_expected.to validate_presence_of(:check_in) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:event) }
  end
end
