# frozen_string_literal: true

# Base Mailer class.
class ApplicationMailer < ActionMailer::Base
  default from: -> { cardswipr_sender }
  layout 'mailer'

  def mail(**params)
    text = ActionController::Base.helpers.strip_tags(render).strip
    super(**params) do |format|
      format.text { text }
      format.html { render }
    end
  end

  private

  def cardswipr_sender
    address = Mail::Address.new ENV['MANDRILL_FROM_EMAIL']
    address.display_name = ENV['MANDRILL_FROM_NAME']
    address.format
  end
end
