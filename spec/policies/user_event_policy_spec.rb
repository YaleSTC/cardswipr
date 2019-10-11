# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEventPolicy do
  subject { described_class }

  context 'with role user' do
    let(:event) { build(:event) }
    let(:user) { build(:user, role: 'user', events: [event]) }
    let(:user_event) { build(:user_event, event: event) }
    let(:other_user) { build(:user, role: 'user', events: []) }

    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, user_event) }
      it { is_expected.not_to permit(other_user, user_event) }
    end

    permissions :create?, :new? do
      it { is_expected.to permit(user, UserEvent) }
    end
  end

  context 'with role superuser' do
    let(:superuser) { build(:user, role: 'superuser') }
    let(:user_event) { build(:user_event) }

    permissions :show?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(superuser, user_event) }
    end

    permissions :create?, :new? do
      it { is_expected.to permit(superuser, UserEvent) }
    end
  end
end
