# frozen_string_literal: true

# Service object to create a user event
# if the given organizer is not already a user, a user object is created
class UserEventCreator
  include ActiveModel::Model
  attr_accessor :user_event
  attr_accessor :user
  attr_accessor :errors
  # Initialize an LookupCreator
  #
  # @param params[:organizer] [String] the netid of the user for the user_event
  # @param param[:event_id] [Integer] the id of the event for the user_event
  def initialize(params)
    @organizer = params[:organizer]
    @event_id = params[:event_id]
  end

  # rubocop:disable Metrics/MethodLength
  def call
    ActiveRecord::Base.transaction do
      @user = find_user
      @user_event = UserEvent.new(user_id: @user.id, event_id: @event_id)
      @user_event.save!
      send_new_organizer_email
      true
    end
  rescue ActiveRecord::RecordInvalid => e
    @errors = e
    false
  # means that PeopleHub failed
  rescue RuntimeError
    @errors = 'User not found'
    @user_event = UserEvent.new(user_id: nil, event_id: nil)
    false
  end
  # rubocop:enable Metrics/MethodLength

  private

  def find_user
    User.find_by(username: @organizer) || create_user
  end

  def create_user
    person = PeopleHub::PersonRequest.get(@organizer)
    User.create!(first_name: person.first_name,
                 last_name: person.last_name,
                 email: person.email, username: person.net_id)
  end

  def send_new_organizer_email
    UserMailer.new_organizer_invitation(user_event: @user_event)
              .deliver
  end
end
