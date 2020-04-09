# frozen_string_literal: true

# Service object to create a Preregistration
class PreregistrationCreator
  attr_accessor :preregistration
  # Initialize a PreregistrationCreator
  #
  # @param event [Event]
  # @param search_param [String] used to query PeopleHub
  def initialize(event:, search_param:)
    @event = event
    @search_param = search_param
  end

  def call
    ActiveRecord::Base.transaction do
      @preregistration = create_preregistration(@search_param)
      true
    end
  rescue ActiveRecord::RecordInvalid, RuntimeError
    false
  end

  def create_preregistration(search_param)
    person = PeopleHub::PersonRequest.get(search_param)
    @event.preregistrations.create!(
      first_name: person.first_name, last_name: person.last_name,
      email: person.email, net_id: person.net_id, upi: person.upi,
      phone: person.phone, checked_in: false
    )
  end
end
