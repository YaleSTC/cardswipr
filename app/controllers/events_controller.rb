# frozen_string_literal: true

require './lib/api/person_request.rb'
# Events Controller
class EventsController < ApplicationController
  before_action :set_event,
                only: %i(show edit index registration destroy check_in)

  def new
    @event = Event.new
  end

  def create
    if EventCreator.new(params: event_params, owner: current_user).call
      redirect_to dashboard_path, notice: 'Successfully created event!'
    else
      redirect_to new_event_path, alert: 'Unable to create event!'
    end
  end

  def show; end

  def edit; end

  def form; end

  def index; end

  def admin; end

  def registration; end

  def check_in
    @attendance = create_attendance(look_up(params[:prox_number]))
    if @attendance.save
      redirect_to registration_event_path(@event),\
                  flash: { success: 'Successfully checked in!' }
    else
      redirect_to registration_event_path(@event),\
                  flash: { error: 'Check-in unsuccessful!' }
    end
  rescue RuntimeError
    redirect_to registration_event_path(@event), flash: { error: 'No match.' }
  end

  def create_attendance(user)
    @event.attendances.build(
      first_name: user[:first_name], last_name: user[:last_name],
      email: user[:email], net_id: user[:net_id], upi: user[:upi],
      check_in: Time.zone.now
    )
  end

  def look_up(prox_number)
    params = { proxnumber: prox_number }
    person = PersonRequest.fetch(ENV['IDENTITY_SERVER_URL'], params)
    { first_name: person['Names']['ReportingNm']['First'],
      last_name: person['Names']['ReportingNm']['Last'],
      email: person['Contacts']['Email'], net_id: person['Identifiers']\
      ['NETID'], upi: person['Identifiers']['UPI'] }
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private

  def set_event
    @event = Event.find(params[:id])
    @attendances = @event.attendances
  end

  def event_params
    params.require(:event).permit(:title, :description)
  end
end
