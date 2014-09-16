class LDAP
  LDAP_HOST = 'directory.yale.edu'
  LDAP_PORT = 389
  LDAP_BASE = 'ou=People,o=yale.edu'
  LDAP_ATTRS = %w(uid givenname sn mail collegename college class UPI)

  # test with LDAP.lookup_by_upi("12714662")
  def self.lookup_by_upi(upi)
    ldap = Net::LDAP.new host: LDAP_HOST, port: LDAP_PORT
    upifilter = Net::LDAP::Filter.eq('UPI', upi)
    ldap_response = ldap.search(base: LDAP_BASE,
                     filter: upifilter,
                     attributes: LDAP_ATTRS)
    extract_attributes(ldap_response)
  end

  def self.extract_attributes(ldap_response)
    # everyone has these
    first_name = ldap_response[0][:givenname][0]
    last_name = ldap_response[0][:sn][0]
    upi = ldap_response[0][:UPI][0]

    # not everyone has these
    netid = ldap_response[0][:uid][0] || ""
    email = ldap_response[0][:mail][0] || ""
    collegename = ldap_response[0][:collegename][0] || ""
    college = ldap_response[0][:college][0] || ""
    class_year = ldap_response[0][:class][0] || ""

    return {
      first_name: first_name,
      last_name: last_name,
      yale_upi: upi,
      netid: netid
      # email: email,
      # collegename: collegename,
      # college: college,
      # class_year: class_year
    }
  end

end