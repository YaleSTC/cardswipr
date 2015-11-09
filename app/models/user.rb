# A user is a user of our application. A user object is created and saved
# to the database after someone logs in with CAS
class User < ActiveRecord::Base
  validates :netid, presence: true, uniqueness: true
  has_and_belongs_to_many :events

  after_create :get_user_attributes

  def get_user_attributes
    api_response = Yale::CardSwiprApiProxy.instance.find_by_netid(netid)
    person = Person.new.update_from_cardswipr_api(api_response)
    attributes = person.attributes.slice('netid', 'first_name', 'last_name', 'nickname', 'email')
    update_attributes(attributes)
  rescue
    Rails.logger.error("ERROR User#get_user_attributes failed for netid #{netid}")
    false # don't actually save it if LDAP fails
  end

  def full_name
    if nickname.blank?
      full_name = first_name + " " + last_name
    else
      full_name = nickname + " " + last_name
    end
  end

  def full_name_with_netid
    full_name + " " + netid
  end
end
