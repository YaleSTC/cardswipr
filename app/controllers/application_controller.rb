class ApplicationController < ActionController::Base

  before_action CASClient::Frameworks::Rails::Filter
  before_action :current_user
  helper_method :current_user
  before_action :add_v2_flash

  check_authorization
  skip_authorization_check only: [:logout]

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_or_create_by(netid: session[:cas_user])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def show_error(code, message)
    flash[:error] = "#{message} (#{code})"
  end

  def add_v2_flash
    flash[:notice] = "We will be releasing a new version of CardSwipr in early 2020 to improve usability and refresh the design. <strong>All of your existing events will be migrated to the new system and your existing card readers will continue to work the way they always have.</strong> If you would like to receive e-mail updates about the release and access a beta (in the next coming weeks), please sign up here: <a href='https://yalesurvey.ca1.qualtrics.com/jfe/form/SV_cRMQ17rCCI9gSwJ' target='_blank'>https://yalesurvey.ca1.qualtrics.com/jfe/form/SV_cRMQ17rCCI9gSwJ</a>.".html_safe
  end
end