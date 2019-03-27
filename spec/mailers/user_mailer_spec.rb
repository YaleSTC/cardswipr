# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { build_stubbed(:user) }
  let(:mail) { UserMailer.welcome_email(user: user) }

  it 'sends a multipart email(html and text)' do
    expect(mail.body.parts.collect(&:content_type))
      .to match(['text/plain; charset=UTF-8', 'text/html; charset=UTF-8'])
  end

  it 'renders the subject' do
    expect(mail.subject).to eql('Welcome to Cardswipr!')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eql([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eql(['cardswipr-example@example.com'])
  end
end
