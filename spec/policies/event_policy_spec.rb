# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPolicy do
  let(:subject) { described_class.new(user, event) }

  let(:event) { create(:event) }

  context 'when user is not logged in' do
    let(:user) { nil }
    let(:policy) { described_class.new(user, event) }

    it 'does not permit anything' do
      expect { described_class.new(nil, event) }
        .to raise_error Pundit::NotAuthorizedError
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user) }

    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:new) }

    describe 'for organizer of event' do
      let(:event) { create(:event, users: [user]) }

      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:edit) }
      it { is_expected.to permit(:destroy) }
    end

    describe 'for non-organizer of event' do
      it { is_expected.not_to permit(:show) }
      it { is_expected.not_to permit(:update) }
      it { is_expected.not_to permit(:edit) }
      it { is_expected.not_to permit(:destroy) }
    end
  end
end
