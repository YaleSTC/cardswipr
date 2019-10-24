# frozen_string_literal: true

require 'csv'

# rubocop:disable Metrics/LineLength, Metrics/AbcSize
# Main class for data import
# Expected UserTable header- "id","first_name","last_name","netid","created_at","updated_at","nickname","email"
# Expected EventTable header- "id","title","description","created_at","updated_at"
# Expected EventUserTable header- "id","event_id","user_id"
# Expected AttendanceEntriesTable header- "id","first_name","nickname","last_name","upi","netid","email","college_name","college_abbreviation","class_year","school","telephone","address","event_id","created_at","updated_at","organization","curriculum"
class DataImporter
  def initialize(user_table_path:, event_table_path:, event_user_table_path:, attendance_entries_table_path:)
    @user_table = read_csv_and_filter_nulls(user_table_path)
    @event_table = read_csv_and_filter_nulls(event_table_path)
    @event_user_table = read_csv_and_filter_nulls(event_user_table_path)
    @attendance_entries_table = read_csv_and_filter_nulls(attendance_entries_table_path)
  end

  def call
    ActiveRecord::Base.transaction do
      insert_users
      insert_events
      insert_user_events
      insert_attendances
      true
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def read_csv_and_filter_nulls(path_to_table)
    CSV.read(path_to_table, headers: true)
       .map(&:to_h)
       .map { |r| r.transform_values { |v| v == 'NULL' ? nil : v } }
  end

  OLD_USER_COLUMNS = %w(first_name last_name id created_at email).freeze
  def insert_users
    @user_table.each do |attrs|
      u = User.find_or_initialize_by(username: attrs['netid'])
      attrs.slice!(*OLD_USER_COLUMNS)
      attrs['v1_id'] = attrs.delete('id')
      u.assign_attributes(attrs)
      u.email = u.username + '@yale.edu' unless u.email.present?
      u.first_name = u.username unless u.first_name.present?
      u.last_name = u.username unless u.last_name.present?
      u.save!
    end
  end

  OLD_EVENT_COLUMNS = %w(title description created_at).freeze
  def insert_events
    @event_table.each do |attrs|
      e = Event.find_or_initialize_by(v1_id: attrs['id'].to_i)
      attrs.slice!(*OLD_EVENT_COLUMNS)
      e.assign_attributes(attrs)
      e.title = "Event ##{e.id}" unless e.title.present?
      e.save!
    end
  end

  def insert_user_events
    @event_user_table.each do |attrs|
      ue = UserEvent.find_or_initialize_by(event: Event.find_by(v1_id: attrs['event_id'].to_i), user: User.find_by(v1_id: attrs['user_id'].to_i))
      ue.save!
    end
  end

  OLD_ATTENDANCE_COLUMNS = %w(first_name last_name upi email telephone created_at updated_at).freeze
  def insert_attendances # rubocop:disable Metrics/MethodLength
    @attendance_entries_table.each do |attrs|
      event = Event.find_by(v1_id: attrs['event_id'])
      next unless event.present?

      a = Attendance.find_or_initialize_by(net_id: attrs['netid'], event: event)
      attrs.slice!(*OLD_ATTENDANCE_COLUMNS)
      attrs['phone'] = attrs.delete('telephone')
      attrs['checked_in_at'] = attrs.delete('updated_at')
      a.assign_attributes(attrs)
      a.email = a.net_id + '@yale.edu' unless a.email.present?
      a.save!
    end
  end
end
# rubocop:enable Metrics/LineLength, Metrics/AbcSize
