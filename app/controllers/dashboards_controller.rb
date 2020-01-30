# frozen_string_literal: true

# Controller for dashboard
class DashboardsController < ApplicationController
  before_action :set_events, only: [:index]

  def index; end

  private

  def set_events
    @events = current_user.events
                          .page(params[:page])
                          .per(5)
                          .order(created_at: :desc)
  end

  def authorize!; end
end
