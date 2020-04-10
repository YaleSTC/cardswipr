# frozen_string_literal: true

# controller for Preregistration
class PreregistrationsController < ApplicationController
  prepend_before_action :set_event, only: %i(index)

  def index
    @preregistrations = @event.preregistrations.order(last_name: :asc)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize!
    authorize(Preregistration.new(event: @event))
  end
end
