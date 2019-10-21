# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEventCreator do
  let(:organizer) { 'ls222' }
  let(:event) { create(:event) }
  let(:creator) do
    described_class.new(organizer: organizer, event_id: event.id)
  end

  context 'when organizer is already a user' do
    it 'successfully creates a user event' do
      create(:user, username: organizer)
      creator.call
      expect(creator.user_event.user.username).to eq(organizer)
    end
  end

  context 'when organizer is not already a user' do
    before { stub_people_hub_with(netid: organizer) }

    it 'creates a user for that organizer' do
      expect { creator.call }.to change(User, :count).by(1)
    end
    it 'successfully creates a user event' do
      creator.call
      expect(creator.user_event.user.username).to eq(organizer)
    end
    it 'sends an email to that user' do
      creator.call
      user_email = creator.user_event.user.email
      mail = ActionMailer::Base.deliveries.last
      expect(mail['to'].to_s).to eq(user_email)
    end
    it 'returns false if peoplehub request fails' do
      stub_failed_people_hub(netid: organizer)
      expect(creator.call).to eq(false)
    end
  end
end
