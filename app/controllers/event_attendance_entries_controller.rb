class EventAttendanceEntriesController < ApplicationController
  before_action :set_event_attendance_entry, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /event_attendance_entries
  # GET /event_attendance_entries.json
  def index
    @event_attendance_entries = EventAttendanceEntry.all
  end

  # GET /event_attendance_entries/1
  # GET /event_attendance_entries/1.json
  def show
  end

  # GET /event_attendance_entries/new
  def new
    @event_attendance_entry = EventAttendanceEntry.new
  end

  # GET /event_attendance_entries/1/edit
  def edit
  end

  # POST /event_attendance_entries
  # POST /event_attendance_entries.json
  def create
    @event_attendance_entry = EventAttendanceEntry.new(event_attendance_entry_params)

    respond_to do |format|
      if @event_attendance_entry.save
        format.html { redirect_to @event_attendance_entry, notice: 'Event attendance entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event_attendance_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_attendance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_attendance_entries/1
  # PATCH/PUT /event_attendance_entries/1.json
  def update
    respond_to do |format|
      if @event_attendance_entry.update(event_attendance_entry_params)
        format.html { redirect_to @event_attendance_entry, notice: 'Event attendance entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_attendance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_attendance_entries/1
  # DELETE /event_attendance_entries/1.json
  def destroy
    @event_attendance_entry.destroy
    respond_to do |format|
      format.html { redirect_to event_attendance_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_attendance_entry
      @event_attendance_entry = EventAttendanceEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_attendance_entry_params
      params.require(:event_attendance_entry).permit(:first_name, :nickname, :last_name, :upi, :netid, :email, :college_name, :college_abbreviation, :class_year, :school, :telephone, :address)
    end
end
