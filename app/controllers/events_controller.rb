require 'yale_id_lookup'

class EventsController < ApplicationController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource param_method: :event_params

  # GET /events
  # GET /events.json
  def index
    @events = @events.reverse
  end

  # GET /events/1
  # GET /events/1.json
  def show
    redirect_to event_attendance_entries_path(@event)
  end

  # GET /events/new
  def new
    # @event = Event.new
    @event.users << current_user
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    # @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render action: 'index', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  # GET /events/1/swipe
  def swipe
    @event = Event.find(params[:event_id])
    authorize! :update, @event
    @count = @event.attendance_entries.count
    render layout: "fullscreen"
  end


  # POST /events/1/lookup
  def lookup
    # authorize! :lookup, :cardswipe
    @event = Event.find(params[:event_id])
    authorize! :update, @event

    # if UPI can't be found, a RuntimeError is thrown and is caught below
    upi = YaleIDLookup.determine_upi(params[:query])

    # automatically attempts LDAP as long as there is a UPI present
    attendanceentry = AttendanceEntry.new(upi: upi, event: @event)
    if attendanceentry.save
      flash[:notice] = "#{attendanceentry.name} has been successfully recorded for this event."
      @count = @event.attendance_entries.count
    else
      flash[:error] = ""
      attendanceentry.errors.each do |attribute, message|
          flash[:error] << message << "\n"
      end
    end

  rescue RuntimeError => e
    flash[:error] ||= ""
    flash[:error] << e.message << "\n"
  ensure
    redirect_to event_swipe_path(@event)
  end

  def wipe_attendance
    @event = Event.find(params[:event_id])
    @event.attendance_entries.destroy_all
    flash[:notice] = "All attendance entries for this event have been wiped."
    redirect_to event_attendance_entries_path(@event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :user_ids => [])
    end
end
