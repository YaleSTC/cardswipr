class AttendanceEntriesController < ApplicationController
  # before_action :set_attendance_entry, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :event
  load_and_authorize_resource :attendance_entry, through: :event, param_method: :attendance_entry_params, :shallow => true


  # GET /attendance_entries
  # GET /attendance_entries.json
  def index
    @count = @attendance_entries.count

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data @attendance_entries.to_csv }
    end
  end

  # GET /attendance_entries/1
  # GET /attendance_entries/1.json
  def show
  end

  # GET /attendance_entries/new
  def new
    @attendance_entry.event = @event
  end

  # GET /attendance_entries/1/edit
  def edit
  end

  # POST /attendance_entries
  # POST /attendance_entries.json
  def create
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
    @attendance_entry.destroy
    respond_to do |format|
      format.html { redirect_to event_attendance_entries_path(@attendance_entry.event) }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_entry_params
      params.require(:attendance_entry).permit(:first_name, :nickname, :last_name, :upi, :netid, :email, :college_name, :college_abbreviation, :class_year, :school, :telephone, :address, :event_id)
    end
end
