# frozen_string_literal: true

# User Events Controller
class UserEventsController < ApplicationController
  before_action :set_event, only: %i(create destroy)
  before_action :set_user_event, only: %i(destroy)

  def create
    @user_event = UserEvent.new(user_event_params)
    username = @user_event.user.username
    if @user_event.save
      redirect_to edit_event_path(@event.id),
                  notice: "#{username} added to event organizers"
    else
      redirect_to edit_event_path(@event.id),
                  alert: "Failed to add #{username} to event organizers"
      flash_alerts(@user_event)
    end
  end

  def destroy
    if @event.user_events.length == 1
      redirect_to edit_event_path(@event.id),
                  alert: 'There must be at least one organizer'
    else
      if @user_event.destroy
        redirect_to edit_event_path(@event.id),
                    notice: "#{@username} removed from event organizers"
      else
        redirect_to edit_event_path(@event.id),
                    alert: "Failed to removed #{@username} from event organizers"
      end
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

  def user_event_params
    params.require(:user_event).permit(:user_id, :event_id)
  end
end
