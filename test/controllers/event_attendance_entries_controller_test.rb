require 'test_helper'

class EventAttendanceEntriesControllerTest < ActionController::TestCase
  setup do
    @event_attendance_entry = event_attendance_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_attendance_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_attendance_entry" do
    assert_difference('EventAttendanceEntry.count') do
      post :create, event_attendance_entry: { address: @event_attendance_entry.address, class_year: @event_attendance_entry.class_year, college_abbreviation: @event_attendance_entry.college_abbreviation, college_name: @event_attendance_entry.college_name, email: @event_attendance_entry.email, first_name: @event_attendance_entry.first_name, last_name: @event_attendance_entry.last_name, netid: @event_attendance_entry.netid, nickname: @event_attendance_entry.nickname, school: @event_attendance_entry.school, telephone: @event_attendance_entry.telephone, upi: @event_attendance_entry.upi }
    end

    assert_redirected_to event_attendance_entry_path(assigns(:event_attendance_entry))
  end

  test "should show event_attendance_entry" do
    get :show, id: @event_attendance_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_attendance_entry
    assert_response :success
  end

  test "should update event_attendance_entry" do
    patch :update, id: @event_attendance_entry, event_attendance_entry: { address: @event_attendance_entry.address, class_year: @event_attendance_entry.class_year, college_abbreviation: @event_attendance_entry.college_abbreviation, college_name: @event_attendance_entry.college_name, email: @event_attendance_entry.email, first_name: @event_attendance_entry.first_name, last_name: @event_attendance_entry.last_name, netid: @event_attendance_entry.netid, nickname: @event_attendance_entry.nickname, school: @event_attendance_entry.school, telephone: @event_attendance_entry.telephone, upi: @event_attendance_entry.upi }
    assert_redirected_to event_attendance_entry_path(assigns(:event_attendance_entry))
  end

  test "should destroy event_attendance_entry" do
    assert_difference('EventAttendanceEntry.count', -1) do
      delete :destroy, id: @event_attendance_entry
    end

    assert_redirected_to event_attendance_entries_path
  end
end
