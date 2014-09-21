require 'net-ldap'
require 'yaleldap'

class Person < ActiveRecord::Base
  establish_connection "oracle"
  self.table_name = "people.ppl_identity_v"

  attr_accessor :upi

  def self.lookup(query)
    determine_upi(query)
  end

  # test with Person.new(upi: "12714662")
  def initialize(attributes)
    attributes = YaleLDAP.lookup(upi: attributes[:upi])
      .slice(:first_name, :last_name, :netid, :upi)
    attributes[:yale_upi] = attributes[:upi]
    super
  end

  def name
    first_name + " " + last_name
  end

  def recorded?
    return Student.find_by(netid: self.netid).present?
  end

  def record
    return false if recorded?
    Student.create(self.student_attrs)
  end

  def student_attrs
    attrs = ["first_name", "last_name", "netid", "yale_upi"]
    # attrs = ["first_name", "last_name", "netid", "yale_upi", "id_card_number"]
    self.attributes.select{|k,v| attrs.include? k}
  end

private
  def self.determine_upi(query)
    if id_number = query.match(/\d{10}/)
      return Person.find_by(id_card_number: id_number[0]).yale_upi.to_i.to_s
    # elsif email = query.match(/SOME YALE EMAIL REGEX/)
    #   return YaleLDAP.lookup(email: query).upi
    else
      return YaleLDAP.lookup(netid: query).upi
    end
  end

end
