class EventAttendanceEntry < ActiveRecord::Base

#has_many people
belongs_to :event

#within an event, upi must be unique
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

  def recorded?
    return EventAttendanceEntry.find_by(upi: self.upi).present?
  end

  def record
    return false if recorded?
    EventAttendanceEntry.create(self.upi)
  end

end
