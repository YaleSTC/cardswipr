# frozen_string_literal: true

# Controller for dashboard
class DashboardsController < ApplicationController
  before_action :set_events, only: [:index]

  def index; end

  private

  def set_events
    @events = current_user.events.order('created_at DESC')
  end

  def authorize!; end
end
