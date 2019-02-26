# frozen_string_literal: true

# Events Controller
class EventsController < ApplicationController
  before_action :set_event, only: %i(show edit index destroy)

  def new
    @event = Event.new
  end

  def show; end

  def edit; end

  def form; end

  def index; end

  def admin; end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
