# frozen_string_literal: true

# Mailer class for user e-mails
class UserMailer < ApplicationMailer
  def new_organizer_invitation(user_event:)
    @event = user_event.event
    @user = user_event.user
    @url = new_user_session_url
    mail(to: @user.email,
         subject: 'You have been granted access to an event on CardSwipr')
  end
end
