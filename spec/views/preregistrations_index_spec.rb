# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'preregistrations/index', type: :view do
  let(:event) { create(:event_with_preregistrations) }

  before do
    assign(:event, event)
    assign(:preregistrations, event.preregistrations)
    time = 'Tue, 25 Aug 2020 23:14:01 EDT -04:00'
    event.preregistrations.first.update(checked_in_at: time)
    event.preregistrations.last.update(checked_in_at: time)
  end

  # There should be a table header and 5 default preregistrations
  it 'lists preregistrations' do
    render
    expect(rendered).to have_css('tr', count: 6)
  end

  it 'highlights rows of checked_in users' do
    render
    expect(rendered).to have_css('tr', style: 'background-color: #cce5ff;',
                                       count: 2)
  end

  it 'shows Preregistrations toggle as active' do
    render
    expect(rendered).to have_css('.toggle-right', class: 'btn-dark')
  end
end
