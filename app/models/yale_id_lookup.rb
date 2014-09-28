# YaleIDLookup is the meat of the application, the most useful part
# This class is used to lookup someone by their magstripe number, netid,
# or Yale email and return an LDAP result to be used elsewhere.
# If this didn't depend on the Oracle connection in `yalecardswipe.rb`
# it could be its own package.
# This also depends on the yaleldap gem
require 'yaleldap'
require 'yale_card_swipe' #not a gem yet, as a model it is autoloaded

module YaleIDLookup

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
    if id_mag_number = query.match(/\d{10}/)
      id_mag_number = id_mag_number[0] #first (only) match
      upi = YaleCardSwipe.lookup(id_mag_number)
    elsif query.match(/.*@yale.edu/)
      upi = YaleLDAP.lookup(email: query)[:upi]
    else
      upi = YaleLDAP.lookup(netid: query)[:upi]
    end
    return upi
  end

end
