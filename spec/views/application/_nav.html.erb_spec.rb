# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'application/_nav.html.erb', type: :view do
  include Pundit

  context 'when user is logged in' do
    let(:user) { create(:user) }

    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:policy) do |record|
        Pundit.policy(user, record)
      end
    end

    it 'has a link to the user\'s profile' do
      fullname = "#{user.first_name} #{user.last_name}"
      render partial: 'application/nav.html.erb',
             locals: { current_user: user }
      expect(response).to have_link(fullname, href: edit_user_path(user.id))
    end
    it 'has a link to Person Lookup' do
      render partial: 'application/nav.html.erb',
             locals: { current_user: user }
      expect(response).to have_link('Person Lookup', href: lookups_path)
    end
    it 'has a link to log out' do
      render partial: 'application/nav.html.erb',
             locals: { current_user: user }
      expect(response).to have_link('Log Out')
    end

    context 'when admin' do
      before { user.update!(role: 'superuser') }

      it 'has an admin dashboard link' do
        render partial: 'application/nav.html.erb',
               locals: { current_user: user }
        expect(response).to have_link('Admin Dashboard', href: admin_users_path)
      end
    end

    context 'when not admin' do
      before { user.update!(role: 'user') }

      it 'does not have an admin dashboard link' do
        render partial: 'application/nav.html.erb',
               locals: { current_user: user }
        expect(response).not_to \
          have_link('Admin Dashboard', href: admin_users_path)
      end
    end
  end
end
