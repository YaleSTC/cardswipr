# An event is owned by many users who can swipe people into the event,
# see the attendance entries list, edit the list
class Event < ActiveRecord::Base

has_and_belongs_to_many :users
validates :users, presence: true
has_many :attendance_entries, dependent: :destroy


  def last_edited
    if attendance_entries.blank?
      return ""
    else
      return attendance_entries.last.swipe_time
    end
  end

end
