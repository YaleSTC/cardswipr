# frozen_string_literal: true

# controller for checking if API and application are live
class HeartbeatController < ActionController::API
  # Route for checking if PeopleHub endpoint is up or down
  def api
    PeopleHub::PersonRequest.get('sl2393')
    render plain: { response: 'API is up', status: :ok }
  rescue RuntimeError
    render plain: { response: 'API is down', status: :service_unavailable }
  end

  # Route for checking if the application is live
  def show
    render plain: 'Application is up.'
  end
end
