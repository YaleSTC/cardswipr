class ApplicationController < ActionController::Base

  before_action CASClient::Frameworks::Rails::Filter
  before_action :current_user
  helper_method :current_user

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

end
