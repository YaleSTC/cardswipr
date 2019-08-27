# frozen_string_literal: true

# Controller for dashboard
class DashboardsController < ApplicationController
  before_action :set_user_events, only: [:index]

  def index; end

  private

  def set_user_events
    @user_events = current_user.user_events.order('created_at DESC')
  end

  def authorize!; end
end
