class ApplicationController < ActionController::Base

  before_action RubyCAS::Filter
  before_action :current_user
  before_action :onlyadmins

  helper_method :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(netid: session[:cas_user])
  end

  def onlyadmins
    admin_users = %w{csw3 jl2463 sbt3 dz65 cb585 deg38 mrd25 }
    unless admin_users.include? session[:cas_user] 
        redirect_to '/unauthorized'
    end
  end

end
