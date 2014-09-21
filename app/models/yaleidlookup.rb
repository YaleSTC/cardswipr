require 'yaleldap'
# require 'yalecardswipe' #not a gem yet

class YaleIDLookup

  # #lookup will accept many formats and attempt to determine the UPI for someone
  # @param [String] accepts magnetic card-swipe, barcode scan, netid, yale email
  # @return [Hash] a hash with a lot of relevant LDAP information, such as:
  #   :first_name, :nickname, :last_name, :upi, :netid,
  #     :email, :college_name, :college_abbreviation,
  #     :class_year, :school, :telephone, :address
  # @example
  #   YaleIDLookup.lookup("s1234567890Z") (magnetic card number, leading & trailing characters)
  #   YaleIDLookup.lookup("1234567890") (magnetic card number, cleaned up)
  #   YaleIDLookup.lookup("casey.watts@yale.edu") (email, not yet)
  #   YaleIDLookup.lookup("csw3") (netid)

  def self.lookup(query)
    upi = determine_upi(query)
    return YaleLDAP.lookup(:upi => upi)
  end

  def self.determine_upi(query)
    if id_mag_number = query.match(/\d{10}/)[0]
      upi = YaleCardSwipe.lookup(id_mag_number)
    # elsif email = query.match(/SOME YALE EMAIL REGEX/)
    #   upi = YaleLDAP.lookup(email: query).upi
    else
      upi = YaleLDAP.lookup(netid: query).upi
    end
    return upi
  end

end
