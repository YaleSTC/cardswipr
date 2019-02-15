# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:user_events) }
    it { is_expected.to have_many(:events).through(:user_events) }
  end
end
