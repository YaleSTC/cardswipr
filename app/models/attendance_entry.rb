# attendance entries are created by an event. This is the permanent record of who has attended an event
# a set of attendance entries for an event can be viewed in the browser or printed to csv
class AttendanceEntry < ActiveRecord::Base

belongs_to :event
validates :event, presence: true
validates :upi, :uniqueness => { :scope => :event, :message => "This person has already been checked into this event." }

after_create :get_ldap_attributes

  # EventAttendanceEntry should be initialized with a upi
  # @param [string] upi = universal personal identification
  # @example
  #   EventAttendanceEntry.new(upi: "12714662", event: 1)
  def get_ldap_attributes
    attributes = YaleLDAP.lookup(upi: upi.to_s)
      .slice(:first_name, :nickname, :last_name, :upi, :netid,
        :email, :college_name, :college_abbreviation,
        :class_year, :school, :telephone, :address)
    self.update_attributes(attributes)
  end

  def name
    if nickname.blank?
      return first_name + " " + last_name
    else
      return nickname + " " + last_name
    end
  end

  # def recorded?
  #   return EventAttendanceEntry.find_by(upi: self.upi).present?
  # end

  # def record
  #   return false if recorded?
  #   EventAttendanceEntry.create(self.upi)
  # end

  def self.to_csv
    columns_to_export = column_names - ["id", "updated_at", "event_id"]
    CSV.generate do |csv|
      csv << columns_to_export
      all.each do |user|
        csv << (user.attributes.values_at(*columns_to_export))
      end
    end
  end

  def swipe_time
    if checked_in
      updated_at.localtime.strftime("%a %b %d, %I:%M %p")
    else
      "not checked in"
    end
  end

end
