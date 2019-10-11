# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  context 'when user is not logged in' do
    it 'does not permit anything' do
      user = nil
      event = build(:event)
      expect { described_class.new(user, event) }
        .to raise_error Pundit::NotAuthorizedError
    end
  end

  context 'with user role' do
    let(:event) { build(:event) }
    let(:user) { build(:user, role: 'user', events: [event]) }
    let(:other_user) { build(:user, role: 'user', events: []) }

    permissions :create?, :new? do
      it { is_expected.to permit(user, Event) }
    end

    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
      it { is_expected.not_to permit(other_user, event) }
    end
  end

  context 'with superuser role' do
    let(:superuser) { build(:user, role: 'superuser') }
    let(:event) { build(:event) }

    permissions :create?, :new? do
      it { is_expected.to permit(superuser, Event) }
    end

    permissions :edit?, :update?, :destroy?, :show? do
      it { is_expected.to permit(superuser, event) }
    end
  end
end
