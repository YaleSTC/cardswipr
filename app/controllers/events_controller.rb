# frozen_string_literal: true

# Events Controller
class EventsController < ApplicationController
  before_action :set_event, only: %i(show edit index)

  def new
    @event = Event.new
  end

  def show; end

  def edit; end

  def form; end

  def index; end

  def admin; end

  private

  def set_event
    @event = Events.find(params[:id])
  end
end
