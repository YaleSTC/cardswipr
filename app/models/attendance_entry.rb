# attendance entries are created by an event. This is the permanent record of who has attended an event
# a set of attendance entries for an event can be viewed in the browser or printed to csv
class AttendanceEntry < ApplicationRecord
  belongs_to :event
  validates :event, presence: true
  validates :upi, :uniqueness => { :scope => :event, :message => "This person has already been checked into this event." }

  after_create :get_directory_attributes

  # EventAttendanceEntry should be initialized with a upi
  # @param [string] upi = universal personal identification
  # @example
  #   EventAttendanceEntry.new(upi: "12714662", event: 1)

  # Get attributes from CardSwipr API and update the model
  def get_directory_attributes
    result = Yale::CardSwiprApiProxy.instance.find_by_upi(upi)
    person = Person.new.update_from_cardswipr_api(result)
    logger.debug('AttendanceEntry#get_directory_attributes ' \
      "person.attributes: #{person.attributes}")
    update_attributes(person.attributes)
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
    #columns_to_export = column_names - ["id", "updated_at", "event_id"]
    columns_to_export = ['first_name', 'nickname', 'last_name', 'upi', 'netid',
      'email', 'telephone']

    CSV.generate do |csv|
      csv << columns_to_export
      all.each do |user|
        csv << (user.attributes.values_at(*columns_to_export))
      end
    end
  end

  def swipe_time
    created_at.localtime.strftime("%Y-%m-%d %I:%M %p")
  end

end
