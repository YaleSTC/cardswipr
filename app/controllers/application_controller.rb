class ApplicationController < ActionController::Base

  before_action :ensure_logged_in
  before_action :current_user
  helper_method :current_user

  check_authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_or_create_by(netid: session['cas']['user'])
  end

  def ensure_logged_in
    if session['cas'].nil? || session['cas']['user'].nil?
      render status: 401, text: "Redirecting to CAS Login..."
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message, :status => :unauthorized
  end

end
