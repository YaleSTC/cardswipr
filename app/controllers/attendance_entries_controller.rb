class AttendanceEntriesController < ApplicationController
  # before_action :set_attendance_entry, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :attendance_entry_params

  # GET /attendance_entries
  # GET /attendance_entries.json
  def index
    @event = Event.find(params[:event_id])
    @attendance_entries = @event.attendance_entries
    @count = @attendance_entries.count

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @attendance_entries.to_csv }
    end
  end

  # GET /attendance_entries/1
  # GET /attendance_entries/1.json
  def show
    @attendance_entry = AttendanceEntry.find(params[:id])
  end

  # GET /attendance_entries/new
  def new
    @event = Event.find(params[:event_id])
    @attendance_entry = AttendanceEntry.new(:event => @event)
  end

  # GET /attendance_entries/1/edit
  def edit
  end

  # POST /attendance_entries
  # POST /attendance_entries.json
  def create
    # @event = Event.find(params[:event_id])
    @attendance_entry = AttendanceEntry.new(attendance_entry_params)

    respond_to do |format|
      if @attendance_entry.save
        format.html { redirect_to event_attendance_entries_path(@attendance_entry.event), notice: 'Event attendance entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attendance_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @attendance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendance_entries/1
  # PATCH/PUT /attendance_entries/1.json
  def update
    respond_to do |format|
      if @attendance_entry.update(attendance_entry_params)
        format.html { redirect_to @attendance_entry, notice: 'Event attendance entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attendance_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_entries/1
  # DELETE /attendance_entries/1.json
  def destroy
    @event = @attendance_entry.event
    @attendance_entry.destroy
    respond_to do |format|
      format.html { redirect_to event_attendance_entries_path(@event) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_entry
      @attendance_entry = AttendanceEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_entry_params
      params.require(:attendance_entry).permit(:first_name, :nickname, :last_name, :upi, :netid, :email, :college_name, :college_abbreviation, :class_year, :school, :telephone, :address, :event_id)
    end
end
