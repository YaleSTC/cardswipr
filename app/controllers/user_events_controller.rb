# frozen_string_literal: true

# User Events Controller
class UserEventsController < ApplicationController
  before_action :set_event, only: %i(create destroy)
  before_action :set_user_event, only: %i(destroy)
  before_action :set_user_events, only: %(create)

  def create
    @creator = UserEventCreator.new(
      search_param: user_event_params
    )
    if @creator.call
      redirect_to edit_event_path(@event.id),
                  notice: display_name(@creator.user)
    else
      redirect_to edit_event_path(@event.id),
                  alert: 'Adding organizer failed'
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

  def display_name(user)
    fn = user.first_name
    ln = user.last_name
    "#{fn} #{ln} added to event organizers"
  end

  def look_up(search_param)
    key = determine_key(search_param)
    PeopleHub::PersonRequest.get(key => search_param)
  end

  # Returns the type of the search param, either prox number or netid
  #
  # @param [String]
  # @return [Symbol] the type of the search param
  def determine_key(search_param)
    if search_param.length == 10 && search_param.match?(/^[0-9]{10}$/)
      :proxnumber
    elsif search_param.match?(/^[a-z]{1,5}[0-9]{1,5}$/)
      :netid
    else
      :invalid_param
    end
  end

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
    params.permit(:id, :user_id, :event_id, :organizer)
  end
end
