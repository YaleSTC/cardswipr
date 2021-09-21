# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances', type: :request do
  describe 'attendances#index' do
    let(:user) { create(:user) }
    let(:event) { create(:event_with_attendances) }
    let(:user_event) { create(:user_event, user: user, event: event) }

    before { login_as(user) }

    it 'displays a list of attendances' do
      get event_attendances_path(user_event.event)
      expect(response.body).to include("#{event.attendances.size} Recorded")
    end

    it 'works if an attendance has no email' do
      create(:attendance, event: event, email: nil)
      get event_attendances_path(user_event.event)
      expect(response.body).to include("#{event.attendances.size} Recorded")
    end
  end
end
