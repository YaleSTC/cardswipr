# frozen_string_literal: true

# Attendees Controller
class AttendeesController < ApplicationController
  def new
    @attendance = Attendance.new
  end

  def index
    @attendance = Attendances.find(params[:id])
  end
end
