class Person < ActiveRecord::Base

  require 'net-ldap'
  LDAP_HOST = 'directory.yale.edu'
  LDAP_PORT = 389
  LDAP_BASE = 'ou=People,o=yale.edu'
  LDAP_ATTRS = %w(uid givenname sn mail collegename college class UPI)


  establish_connection "oracle"
  self.table_name = "people.ppl_identity_v"

  def self.lookup(query)
    if id_number = query.match(/\d{10}/)
      return Person.find_by(id_card_number: id_number[0])
    else
      return Person.find_by(netid: query)
    end
  end

  # test with Person.ldap_lookup_by_upi("12714662")
  def ldap_lookup_by_upi(upi)
    # lookup in ldap, return raw LDAP information
    ldap = Net::LDAP.new host: LDAP_HOST, port: LDAP_PORT
    upifilter = Net::LDAP::Filter.eq('UPI', upi)
    ldap_response = ldap.search(base: LDAP_BASE,
                     filter: upifilter,
                     attributes: LDAP_ATTRS)
    
    assign_ldap_attributes(ldap_response)
  end

  def assign_ldap_attributes(ldap_response)
    @first_name = ldap_response[0][:givenname][0]
    @last_name = ldap_response[0][:sn][0]
    @upi = ldap_response[0][:UPI][0]

    # not everyone has these
    @netid = ldap_response[0][:uid][0] || ""
    @email = ldap_response[0][:mail][0] || ""
    @collegename = ldap_response[0][:collegename][0] || ""
    @college = ldap_response[0][:college][0] || ""
    @class_year = ldap_response[0][:class][0] || ""
  end
    # return {
    #   first_name: first_name,
    #   last_name: last_name,
    #   upi: upi,
    #   netid: netid,
    #   email: email,
    #   collegename: collegename,
    #   college: college,
    #   class_year: class_year
    # }
  # end

  # def self.get_ldap_attributes(upi)
  #   result = self.ldaplookupbyupi(upi)
    
  # end

  # test with Person.new("12714662")
  def initialize(upi)
    ldap_lookup_by_upi(upi)
    super
    # binding.pry
  end

  def name
    #lookup in LDAP
    first_name + " " + last_name
  end

  # def roles
  #   Role.upi(self.yale_upi)
  # end

  # def undergrad?
  #   roles.undergrad.any?
  # end

  # def grad_student?
  #   roles.grad.any?
  # end

  # def student_roles
  #   [roles.undergrad, roles.grad].flatten
  # end

  # def allowed_year?
  #   allowed_years = Setting.allowed_years
  #   student_roles.each do |role|
  #     return true if allowed_years.include?(role.class_year)
  #   end
  #   return false
  # end

  def given_key?
    return Student.find_by(netid: self.netid).present?
  end

  def give_key
    return false if given_key?
    Student.create(self.student_attrs)
  end

  # def student_attrs
  #   attrs = ["first_name", "last_name", "netid", "yale_upi", "id_card_number"]
  #   self.attributes.select{|k,v| attrs.include? k}
  # end

end
