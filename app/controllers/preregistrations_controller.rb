# frozen_string_literal: true

# controller for Preregistration
class PreregistrationsController < ApplicationController
  prepend_before_action :set_event, only: %i(index new create destroy import)

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

  def new
    @preregistration = Preregistration.new
  end

  def create
    creator = PreregistrationCreator.new(
      event: @event, search_param: params[:search_param]
    )
    if creator.call
      redirect_to new_event_preregistration_path(@event),
                  notice: "Successfully preregistered
                  #{creator.preregistration.full_name}!"
    else
      redirect_to new_event_preregistration_path(@event),
                  alert: 'Preregistration failed'
    end
  end

  def import
    if params[:file]
      import_preregistrations
    else
      redirect_to new_event_preregistration_path(@event),
                  alert: 'Please upload a CSV file'
    end
  end

  private

  def preregistration_params
    params.require(:preregistration).permit(:search_param)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def authorize!
    authorize(Preregistration.new(event: @event))
  end

  def import_preregistrations
    importer = PreregistrationImporter.new(event: @event,
                                           path: params[:file].path)
    if importer.call
      redirect_to event_preregistrations_path(@event), notice:
        "Successfully uploaded #{importer.count} preregistrations!"
    else
      redirect_to new_event_preregistration_path(@event),
                  alert: 'Unsupported file format'
    end
  end
end
