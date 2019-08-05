# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user_event) { create(:user_event) }
  let(:new_organizer_mail) do
    UserMailer.new_organizer_invitation(user_event: user_event)
  end

  it 'sends a multipart email(html and text)' do
    expect(new_organizer_mail.body.parts.collect(&:content_type))
      .to match(['text/plain; charset=UTF-8', 'text/html; charset=UTF-8'])
  end
end
