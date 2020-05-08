# frozen_string_literal: true

# Events Controller
class EventsController < ApplicationController
  prepend_before_action :set_event, only: %i(show edit update destroy)
  before_action :set_user_events, only: %i(edit update)
  layout 'application_without_nav_or_footer', only: %i(show)

  def new
    @event = Event.new
  end

  def create
    obj = EventCreator.new(params: event_params, owner: current_user)
    if obj.call
      redirect_to event_attendances_path(obj.event),
                  notice: 'Successfully created event!'
    else
      @event = obj.event
      flash_alerts(obj)
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to edit_event_path(@event.id), notice: 'Event Updated'
    else
      flash_alerts(@event)
      render 'edit', event: @event.id
    end
  end

  def destroy
    @event.destroy
    redirect_to dashboard_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_user_events
    @user_event = UserEvent.new
    @user_events = @event.user_events
                         .joins(:user).order(Arel.sql('lower(last_name)'))
  end

  def event_params
    params.require(:event).permit(:title, :description, :preregistration)
  end

  def authorize!
    if @event
      authorize(@event)
    else
      authorize Event.new
    end
  end
end
