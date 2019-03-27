# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(user: User.first)
  end
end
