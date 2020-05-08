# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'preregistrations/index', type: :view do
  let(:event) { create(:event_with_preregistrations) }

  before do
    assign(:event, event)
    assign(:preregistrations, event.preregistrations)
    event.preregistrations.first.update(checked_in: true)
    event.preregistrations.last.update(checked_in: true)
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
end
