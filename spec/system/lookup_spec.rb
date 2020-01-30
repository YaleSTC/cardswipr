# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lookup', type: :system do
  let(:user) { create(:user) }

  before do
    stub_and_sign_in(user)
  end

  context 'when lookup is successful' do
    before { stub_people_hub }

    it 'displays person info' do
      look_up('ls222')
      expect(page).to have_content('Luke Skywalker')
    end

    it 'displays a link to the Yale Phonebook entry' do
      upi = '12345678'
      look_up(upi)
      link = "http://directory.yale.edu/?queryType=field&upi=#{upi}"
      expect(find('#yale-phonebook')[:href]).to eq(link)
    end
  end

  it 'displays a message for failed look-up' do
    stub_failed_people_hub('1')
    look_up('1')
    expect(page).to have_content('Look-up failed')
  end

  def look_up(search_param)
    visit lookups_path
    fill_in 'search_param', with: search_param
    click_on 'Submit'
  end

  def stub_and_sign_in(user)
    stub_cas(user.username)
    sign_in user
  end
end
