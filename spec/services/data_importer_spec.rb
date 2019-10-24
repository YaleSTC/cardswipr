# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DataImporter do
  let(:fixture_import_params) do
    root = Rails.root.join('spec', 'fixtures', 'data_import')
    { user_table_path: "#{root}/users.csv",
      event_table_path: "#{root}/events.csv",
      event_user_table_path: "#{root}/events_users.csv",
      attendance_entries_table_path: "#{root}/attendance_entries.csv" }
  end

  describe 'on intialization' do
    it 'reads exported csv files correctly' do
      expect { described_class.new(fixture_import_params) }.not_to(raise_error)
    end
  end

  describe '#call' do
    let(:user) { build(:user, username: 'tst123') }
    let(:event) { build(:event, v1_id: 1) }
    let(:user_event) { build_stubbed(:user_event, event: event, user: user) }
    let(:attendance) { build_stubbed(:attendance, event: event) }

    before do
      allow(user).to receive(:save!).and_return(true)
      allow(event).to receive(:save!).and_return(true)
      allow(user_event).to receive(:save!).and_return(true)
      allow(attendance).to receive(:save!).and_return(true)

      allow(User).to receive(:find_or_initialize_by).and_return(user)
      allow(User).to receive(:find_by).and_return(user)
      allow(Event).to receive(:find_or_initialize_by).and_return(event)
      allow(Event).to receive(:find_by).and_return(event)
      allow(UserEvent).to receive(:find_or_initialize_by).and_return(user_event)
      allow(Attendance).to receive(:find_or_initialize_by)
        .and_return(attendance)
    end

    describe 'succeeds' do
      it 'saves all objects correctly' do
        expect(described_class.new(fixture_import_params).call).to eq(true)
      end

      describe 'all objects are valid' do # rubocop:disable RSpec/NestedGroups
        before { described_class.new(fixture_import_params).call }

        it 'user is valid' do
          expect(user).to be_valid
        end

        it 'event is valid' do
          expect(event).to be_valid
        end

        it 'user_event is valid' do
          expect(user_event).to be_valid
        end

        it 'attendance is valid' do
          expect(attendance).to be_valid
        end
      end

      describe 'all objects were saved' do # rubocop:disable RSpec/NestedGroups
        before { described_class.new(fixture_import_params).call }

        it 'user is valid' do
          expect(user).to have_received(:save!)
        end

        it 'event is valid' do
          expect(event).to have_received(:save!)
        end

        it 'user_event is valid' do
          expect(user_event).to have_received(:save!)
        end

        it 'attendance is valid' do
          expect(attendance).to have_received(:save!)
        end
      end
    end

    describe 'failure' do
      before do
        allow(user).to receive(:save!).and_raise(ActiveRecord::RecordInvalid)
      end

      it 'returns false' do
        expect(described_class.new(fixture_import_params).call).to eq(false)
      end
    end
  end
end
