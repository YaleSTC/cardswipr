# YaleIDLookup is the meat of the application, the most useful part
# This class is used to lookup someone by their magstripe number, netid,
# or Yale email and return an LDAP result to be used elsewhere.
# If this didn't depend on the Oracle connection in `yalecardswipe.rb`
# it could be its own package.
# This also depends on the yaleldap gem
module YaleIDLookup
  # #lookup will accept many formats and attempt to determine the UPI for
  #   someone
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
  def self.lookup(query_str)
    api = Yale::CardSwiprApiProxy.instance
    m = query_str.match(/\d{10}/)

    if m # ID number could be magstripe or prox, both are 10 digit
      v = m[0] # first (only) match
      result = api.find_by_prox_num(v) || api.find_by_mag_stripe_num(v)
    elsif query_str.match(/.*@yale.edu/)
      result = api.find_by_email(query_str)
    else
      result = api.find_by_netid(query_str)
    end

    Rails.logger.debug("YaleIDLookup.lookup result: #{result}")
    result ? Person.new.update_from_cardswipr_api(result) : nil
  rescue RuntimeError, NameError => e
    Rails.logger.error("ERROR YaleIDLookup.determine_upi #{e}")
    nil
  end

end
