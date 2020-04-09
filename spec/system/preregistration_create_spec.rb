# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe 'Preregistration creation', type: :system do
  let(:user) { create(:user) }
  let(:event) { create(:event_with_preregistrations) }
  let(:net_id) { 'ls222' }

  before do
    create(:user_event, user: user, event: event)
    log_in user
    visit event_preregistrations_path(event.id)
    click_on 'Add Preregistrations'
  end

  it 'displays a message for successful preregistration' do
    stub_people_hub_with(net_id)
    add_preregistration(net_id)
    expect(page).to have_content('Successfully preregistered')
  end

  it 'displays a message for failed preregistration' do
    stub_failed_people_hub(net_id)
    add_preregistration(net_id)
    expect(page).to have_content('Preregistration failed')
  end

  it 'does not allow duplicate preregistrations' do
    prereg = create(:preregistration, event: event, net_id: net_id)
    stub_people_hub(prereg.email)
    add_preregistration(net_id)
    expect(page).to have_content('Preregistration failed')
  end

  context 'with csv import' do
    let(:pathname) do
      Rails.root.join('spec', 'fixtures', 'prereg_import', 'search_params.csv')
    end

    before do
      CSV.foreach(pathname, headers: true) do |row|
        stub_people_hub_with(row[0], row[0] + '@yale.edu')
      end
    end

    it 'creates one preregistration for each search param' do
      expect { import_preregistrations(pathname) }.to \
        change(event.preregistrations, :count).by(count(pathname))
    end

    it 'successfully creates preregistrations using the template' do
      template_path = Rails.root.join('public',
                                      'preregistration_import_template.csv')
      expect { import_preregistrations(template_path) }.to \
        change(event.preregistrations, :count).by(count(template_path))
    end

    it 'fails to create preregistrations for invalid search params' do
      stub_failed_people_hub('netid1')
      expect { import_preregistrations(pathname) }.to \
        change(Preregistration, :count).by(count(pathname) - 1)
    end

    it 'has a link to template csv' do
      click_on 'Download template'
      expect(page).to have_content('NetID')
    end

    it 'displays an error message when given wrong format for import file' do
      badfile = Rails.root.join('spec', 'fixtures', 'prereg_import',
                                'wrong_format.xlsx')
      import_preregistrations(badfile)
      expect(page).to have_content('Unsupported file format')
    end
  end

  def log_in(user)
    stub_people_hub
    stub_cas(user.username)
    sign_in user
  end

  def add_preregistration(search_param)
    fill_in 'search_param', with: search_param
    click_on 'Add Preregistration'
  end

  def import_preregistrations(pathname)
    attach_file('file', pathname)
    click_on 'Import CSV'
  end

  # returns the number of data rows in the file, not counting the header
  # @param path [PathName]
  def count(path)
    path.each_line.count - 1
  end
end
