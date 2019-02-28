# frozen_string_literal: true

# Service object to create an Event
class EventCreator
  # Initialize an EventCreator
  #
  # @param params [ActionController::Parameters] parameters for the event
  # @param owner [User] the user that will be set as the owner of the new event
  def initialize(params:, owner:)
    @params = params
    @owner = owner
  end

  def call
    ActiveRecord::Base.transaction do
      @event = Event.create!(@params)
      @user_event = UserEvent.create!(user_id: @owner.id, event_id: @event.id,
                                      owner: true)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
