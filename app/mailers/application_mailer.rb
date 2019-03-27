# frozen_string_literal: true

# Base Mailer class
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
    address = Mail::Address.new 'cardswipr-example@example.com'
    address.display_name = 'Cardswipr Example'
    address.format
  end
end
