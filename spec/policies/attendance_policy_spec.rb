# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendancePolicy do
  subject { described_class }

  context 'with user role' do
    let(:event) { build(:event) }
    let(:user) { build(:user, role: 'user', events: [event]) }
    let(:other_user) { build(:user, role: 'user', events: []) }
    let(:attendance) { build(:attendance, event: event) }

    permissions :index?, :destroy?, :export? do
      it { is_expected.to permit(user, attendance) }
      it { is_expected.not_to permit(other_user, attendance) }
    end

    permissions :create? do
      it { is_expected.to permit(user, Attendance) }
    end
  end

  context 'with superuser role' do
    let(:superuser) { build(:user, role: 'superuser') }
    let(:attendance) { build(:attendance) }

    permissions :index?, :destroy?, :export? do
      it { is_expected.to permit(superuser, attendance) }
    end

    permissions :create? do
      it { is_expected.to permit(superuser, Attendance) }
    end
  end
end
