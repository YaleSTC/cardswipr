class User < ActiveRecord::Base
  validates :netid, presence: true, uniqueness: true
  has_and_belongs_to_many :event

  after_create :get_ldap_attributes

  def get_ldap_attributes
    attributes = YaleLDAP.lookup(netid: netid)
      .slice(:first_name, :last_name, :netid)
    self.update_attributes(attributes)
  end

end
