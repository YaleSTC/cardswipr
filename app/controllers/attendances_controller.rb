# frozen_string_literal: true

# controller for Attendance
class AttendancesController < ApplicationController
  before_action :set_event, only: %i(new index export)

  def new
    @attendance = Attendance.new
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
end
