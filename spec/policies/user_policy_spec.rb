# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  context 'with role user' do
    let(:user) { build(:user, role: 'user') }
    let(:other_user) { build(:user, role: 'user') }

    permissions :show?, :destroy?, :update?, :edit? do
      it { is_expected.to permit(user, user) }
      it { is_expected.not_to permit(user, other_user) }
    end
  end

  context 'with role superuser' do
    let(:superuser) { build_stubbed(:user, role: 'superuser') }
    let(:other_user) { build(:user, role: 'user') }

    permissions :show?, :destroy?, :update?, :edit? do
      it { is_expected.to permit(superuser, superuser) }
      it { is_expected.to permit(superuser, other_user) }
    end
  end
end
