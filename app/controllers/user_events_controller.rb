# frozen_string_literal: true

# User Events Controller
class UserEventsController < ApplicationController
  before_action :set_event, only: %i(create destroy)
  before_action :set_user_event, only: %i(destroy)
  before_action :set_user_events, only: %(create)

  def create
    @user_event = UserEvent.new(user_event_params)
    username = @user_event.user.username
    if @user_event.save
      redirect_to edit_event_path(@event.id),
                  notice: "#{username} added to event organizers"
    else
      flash_alerts(@user_event)
      render 'events/edit', event: @event.id
    end
  end

  def destroy
    if @event.user_events.length == 1
      redirect_to edit_event_path(@event.id),
                  alert: 'There must be at least one organizer'
    elsif @user_event.destroy
      redirect_to edit_event_path(@event.id),
                  notice: "#{@username} removed from event organizers"
    else
      redirect_to edit_event_path(@event.id),
                  alert: "Failed to remove #{@username} from event organizers"
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_user_event
    @user_event = UserEvent.find(params[:id])
    @username = @user_event.user.username
  end

  # needed to render events/edit
  def set_user_events
    @user_events = @event.user_events
                         .joins(:user).order(Arel.sql('lower(username)'))
  end

  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id)
  end

  def authorize!; end
end
