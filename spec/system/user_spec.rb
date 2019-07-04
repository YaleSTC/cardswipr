# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:username) { 'ls222' }
  let(:email) { 'luke.skywalker@mail.com' }

  it 'has correct email address' do
    stub_people_hub(email)
    stub_and_sign_in(username)
    user = User.find_by(username: username)
    expect(user.email).to eq(email)
  end

  def stub_and_sign_in(username)
    stub_cas(username)
    visit root_path
    click_on 'Log in'
  end
end
