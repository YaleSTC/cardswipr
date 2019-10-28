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

  describe '#full_name' do
    it 'is the first name and last name' do
      full_name = 'Luke Skywalker'
      user = build_stubbed(:user, first_name: 'Luke', last_name: 'Skywalker')
      expect(user.full_name).to eq(full_name)
    end
  end
end
