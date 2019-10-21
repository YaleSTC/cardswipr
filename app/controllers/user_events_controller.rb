# frozen_string_literal: true

# User Events Controller
class UserEventsController < ApplicationController
  before_action :set_event, only: %i(create destroy)
  before_action :set_user_event, only: %i(destroy)
  before_action :set_user_events, only: %i(create)

  def create
    @creator = UserEventCreator.new(user_event_params)
    if @creator.call
      redirect_to edit_event_path(@event.id),
                  notice: "#{@creator.user.full_name} added to event organizers"
    else
      flash['alert'] = @creator.errors
      @user_event = @creator.user_event
      render 'events/edit', event: @event.id
    end
  end

  def destroy
    if @event.user_events.length == 1
      redirect_to edit_event_path(@event.id),
                  alert: 'There must be at least one organizer'
    elsif @user_event.destroy
      redirect_to edit_event_path(@event.id),
                  notice: "#{@full_name} removed from event organizers"
    else
      redirect_to edit_event_path(@event.id),
                  alert: "Failed to remove #{@full_name} from event organizers"
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user_event
    @user_event = UserEvent.find(params[:id])
    @full_name = @user_event.user.full_name
  end

  # needed to render events/edit
  def set_user_events
    @user_events = @event.user_events
                         .joins(:user).order(Arel.sql('lower(username)'))
  end

  def user_event_params
    params.permit(:organizer, :event_id)
  end

  def authorize!; end
end
