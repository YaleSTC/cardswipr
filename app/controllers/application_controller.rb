class ApplicationController < ActionController::Base

  before_action RubyCAS::Filter
  before_action :current_user
  before_action :onlyadmins

  helper_method :current_user

  # check_authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_or_create_by(netid: session[:cas_user])
  end

  def onlyadmins
    admin_users = %w{csw3 jl2463 sbt3 dz65 cb585 deg38 mrd25 cb785}
    unless admin_users.include? session[:cas_user] 
        redirect_to '/unauthorized'
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    # redirect_to root_url, :alert => exception.message
    render plain: "Not Authorized"
  end

end
