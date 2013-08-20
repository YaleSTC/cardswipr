class ApplicationController < ActionController::Base

  before_action RubyCAS::Filter
  before_action :current_user

  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(netid: session[:cas_user])
  end

end
