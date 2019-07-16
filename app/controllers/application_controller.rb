# frozen_string_literal: true

# Base controller class.
class ApplicationController < ActionController::Base
  before_action :redirect_to_home_page, unless: :public_action?

  private

  def redirect_to_home_page
    return if user_signed_in?

    redirect_to root_path
    flash[:alert] = 'Please sign in to view that page'
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
