# frozen_string_literal: true

# Service object to create a UserEvent
class UserEventCreator
  attr_accessor :user
  attr_accessor :user_event
  # Initialize an UserEventCreator
  #
  # @param event [Event]
  # @param search_param [String]
  def initialize(search_param:)
    @organizer = search_param[:organizer]
    @event_id = search_param[:event_id]
  end

  def call
    ActiveRecord::Base.transaction do
      @user = create_user
      @user_event = create_user_event
      true
    end
  rescue ActiveRecord::RecordInvalid, RuntimeError
    false
  end

  def create_user
    User.find_by(username: @organizer) || fake_user
  end

  def create_user_event
    @user_event = UserEvent.create!(user_id: @user.id,
                                    event_id: @event_id,
                                    owner: true)
  end

  def fake_user
    organizer = look_up(@organizer)
    User.create!(first_name: organizer.first_name,
                 last_name: organizer.last_name,
                 email: organizer.email, username: organizer.net_id)
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
end
