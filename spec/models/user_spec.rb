# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'basic validation' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:user_events) }
    it { is_expected.to have_many(:events).through(:user_events) }
  end
end
