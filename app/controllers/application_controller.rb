# frozen_string_literal: true

# Base controller class.
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  before_action :redirect_to_home_page, unless: :public_action?
  before_action :authorize!, unless: :public_action?

  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = 'Sorry, you don\'t have permission to do that.'
    redirect_to(root_path)
  end

  private

  def redirect_to_home_page
    return if user_signed_in?

    redirect_to root_path
    flash[:alert] = 'Please sign in to view that page'
  end

  def public_action?
    devise_controller? || self.class == HighVoltage::PagesController
  end

  def after_sign_in_path_for(user)
    if user.persisted?
      super user
    else
      person_attrs_to_user(user)
      user.save!
      user_session_path(user)
    end
  rescue StandardError
    flash[:alert] = 'We were unable to create your account. Please try later.'
    root_path
  end

  # to be used when rendering, not redirecting
  def flash_alerts(instance)
    instance.errors.full_messages.each do |message|
      flash.now[:alert] = message
    end
  end

  # retrieve and assign associated attributes from peoplehub to user
  def person_attrs_to_user(user)
    person = PeopleHub::PersonRequest.get(netid: user.username)
    user.email = person.email
    user.first_name = person.first_name
    user.last_name = person.last_name
  end
end
