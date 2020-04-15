# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreregistrationPolicy do
  subject { described_class }

  describe 'for event without preregistration' do
    let(:event) { build(:event, preregistration: false) }
    let(:preregistration) { build(:preregistration, event: event) }

    context 'with user role' do
      let(:user) { build(:user, role: 'user', events: [event]) }

      permissions :create?, :index?, :destroy?, :import? do
        it { is_expected.not_to permit(user, preregistration) }
      end
    end

    context 'with superuser role' do
      let(:superuser) { build(:user, role: 'superuser') }

      permissions :create?, :index?, :destroy?, :import? do
        it { is_expected.not_to permit(superuser, preregistration) }
      end
    end
  end

  describe 'for event with preregistration' do
    let(:event) { build(:event, preregistration: true) }
    let(:preregistration) { build(:preregistration, event: event) }

    context 'with user role' do
      let(:user) { build(:user, role: 'user', events: [event]) }
      let(:other_user) { build(:user, role: 'user', events: []) }

      permissions :create?, :index?, :destroy?, :import? do
        it { is_expected.to permit(user, preregistration) }
        it { is_expected.not_to permit(other_user, preregistration) }
      end
    end

    context 'with superuser role' do
      let(:superuser) { build(:user, role: 'superuser') }

      permissions :create?, :index?, :destroy?, :import? do
        it { is_expected.to permit(superuser, preregistration) }
      end
    end
  end
end
