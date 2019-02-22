# frozen_string_literal: true

# controller for Attendance
class AttendancesController < ApplicationController
  before_action :set_event, only: %i(create index export)

  def create
    @creator = AttendanceCreator.new(
      event: @event, search_param: params[:search_param]
    )
    if @creator.call
      redirect_to event_path(@event),
                  notice: "Successfully checked in
                  #{@creator.attendance.first_name}
                  #{@creator.attendance.last_name}!"
    else
      redirect_to event_path(@event),
                  alert: 'Check-in failed'
    end
  end

  def index
    @attendances = @event.attendances
  end

  def export
    @attendances = @event.attendances
    generator = CSVGenerator.new(data: @attendances)
    if generator.generate
      send_data(generator.csv, filename: csv_filename, type: 'text/csv')
    else
      flash_alerts(generator)
      render 'index'
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def csv_filename
    time_str = Time.zone.today.to_s(:number)
    event_name = @event.title.parameterize.underscore[0..15]
    "#{event_name}_export_#{time_str}.csv"
  end

  def attendance_params
    params.require(:attendance).permit(:search_param)
  end
end
