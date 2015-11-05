require 'yaleldap'

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
    upi = determine_upi(query_str)
    upi ? YaleLDAP.lookup(upi: upi) : nil
  end

  def self.determine_upi(query_str)
    api = Yale::CardSwiprApiProxy.instance
    m = query_str.match(/\d{10}/)

    if m  # ID number could be magstripe or prox, both are 10 digit
      v = m[0]  # first (only) match
      response = api.send(build_query('proxNumber', v)) ||
                 api.send(build_query('magstripenumber', v))
    elsif query_str.match(/.*@yale.edu/)
      response = api.send(build_query('email', query_str))
    else
      response = api.send(build_query('netid', query_str))
    end

    Rails.logger.debug("YaleIDLookup.determine_upi result: #{response}")
    response['ServiceResponse']['Record']['Upi']
  rescue RuntimeError, NameError => e
    Rails.logger.error("ERROR YaleIDLookup.determine_upi #{e}")
    nil
  end

  def self.determine_type(query_str)
  end

  def self.build_query(query_key, query_value)
    query = "?type=json&#{query_key}=#{query_value}"
    Rails.logger.debug("YaleIDLookkup.build_query query: #{query}")
    query
  end
end
