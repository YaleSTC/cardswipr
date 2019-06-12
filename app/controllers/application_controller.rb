# frozen_string_literal: true

# Base controller class.
class ApplicationController < ActionController::Base
  before_action :redirect_to_sign_in, unless: :public_action?

  private

  def redirect_to_sign_in
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def public_action?
    devise_controller? || self.class == HighVoltage::PagesController
  end

  # to be used when rendering, not redirecting
  def flash_alerts(instance)
    instance.errors.full_messages.each do |message|
      flash.now[:alert] = message
    end
  end
end
