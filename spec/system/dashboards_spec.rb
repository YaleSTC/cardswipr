# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :system do
  before { stub_cas(user_with_events.username) }

  context 'when signed in as user' do
    let(:user_with_events) { FactoryBot.create(:user_with_events) }

    it 'lists user events' do
      visit dashboard_path
      table = page.find(:css, 'table#events')
      row_count = table.all(:css, 'tbody/tr').size
      expect(row_count).to eq(5)
    end
  end
end
