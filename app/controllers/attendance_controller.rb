# frozen_string_literal: true

# controller for Attendance
class AttendanceController < ApplicationController
  before_action :set_event

  def new
    @attendance = Attendance.new
  end

  def index
    @attendances = @event.attendances
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
