class Event < ActiveRecord::Base

has_and_belongs_to_many :users
validates :users, presence: true
has_many :attendance_entries


  def last_edited
    if attendance_entries.blank?
      return ""
    else
      return attendance_entries.last.swipe_time
    end
  end

end
