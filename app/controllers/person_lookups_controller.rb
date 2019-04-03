# frozen_string_literal: true

require './lib/api/person_request.rb'
# PersonLoookups Controller
class PersonLookupsController < ApplicationController
  before_action :set_person
  after_action :reset_lookup, only: [:new]
  def new; end

  def create
    api_params = match_arguments(params[:arguments])
    if api_params.nil?
      redirect_to new_person_lookup_path, flash: { error: 'Invalid Input!' }
    else
      session[:person] = fetch_api(api_params)
      set_person
      redirect_to new_person_lookup_path
    end
  rescue RuntimeError
    redirect_to new_person_lookup_path, flash: { error: 'No match found!' }
  end

  private

  def match_arguments(argument)
    if argument.match?(/[a-zA-Z]{1,3}\d{1,3}/)
      { netid: argument }
    elsif argument.match?(/\d{9}/)
      { proxnumber: argument }
    end
  end

  def fetch_api(api_params)
    person = PersonRequest.fetch(ENV['IDENTITY_SERVER_URL'], api_params)
    { first_name: person['Names']['ReportingNm']['First'],
      last_name: person['Names']['ReportingNm']['Last'],
      email: person['Contacts']['Email'], net_id: person['Identifiers']\
      ['NETID'], upi: person['Identifiers']['UPI'] }
  end

  def set_person
    @person = session[:person]
  end

  def reset_lookup
    session[:person] = nil
  end
end
