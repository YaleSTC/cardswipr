# frozen_string_literal: true

# controller for Preregistration
class PreregistrationsController < ApplicationController
  prepend_before_action :set_event, only: %i(index destroy)

  def index
    @preregistrations = @event.preregistrations.order(last_name: :asc)
  end

  def destroy
    preregistration = Preregistration.find(params[:id])
    if preregistration.destroy
      redirect_to event_preregistrations_path(@event),
                  notice: 'Successfully deleted preregistration!'
    else
      redirect_to event_preregistrations_path(@event),
                  alert: 'Failed to delete preregistration'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize!
    authorize(Preregistration.new(event: @event))
  end
end
