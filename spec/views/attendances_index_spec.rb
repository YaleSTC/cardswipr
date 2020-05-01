# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/index', type: :view do
  before { @attendances = [] }

  context 'with preregistration' do
    before { @event = create(:event, preregistration: true) }

    it 'shows Attendances toggle as active' do
      render
      expect(rendered).to have_css('.toggle-left', class: 'btn-dark')
    end
  end

  context 'without preregistration' do
    before { @event = create(:event, preregistration: false) }

    it 'does not render toggle' do
      render
      expect(rendered).not_to have_css('.toggle-left')
    end
  end
end
