# frozen_string_literal: true

# Events Controller
class EventsController < ApplicationController
  before_action :set_event, only: %i(show edit index destroy)

  def new
    @event = Event.new
  end

  def create
    if EventCreator.new(params: event_params, owner: current_user).call
      redirect_to dashboard_path, notice: 'Successfully created event!'
    else
      redirect_to new_event_path, alert: 'Unable to create event!'
    end
  end

  def show; end

  def edit; end

  def form; end

  def index; end

  def admin; end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description)
  end
end
