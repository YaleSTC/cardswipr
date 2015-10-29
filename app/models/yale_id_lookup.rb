require 'yaleldap'
require 'yale_card_swipe' # not a gem yet, as a model it is autoloaded

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
    api = Yale::ApiProxy.instance
    query_type = determine_type(query_str)
    Rails.logger.debug("YaleIDLookup.lookup query_type: #{query_type}")

    if query_type == 'prox_or_magstripe'
      return api.send(build_query('proxNumber', query_str)) ||
        api.send(build_query('magstripenumber', query_str))
    else
      return api.send(build_query(query_type, query_str))
    end
  end

  def self.determine_upi(query_str)
      lookup_result = lookup(query_str)
      Rails.logger.debug("YaleIDLookup.determine_upi result: #{lookup_result}")
      lookup_result['ServiceResponse']['Record']['Upi']
  end

  def self.determine_type(query_str)
    # id_number could be magstripe or prox, both are 10 digit
    if query_str.match(/\d{10}/)
      return 'prox_or_magstripe'
    elsif query_str.match(/.*@yale.edu/)
      return 'email'
    else
      return 'netid'
    end
  end

  def self.build_query(query_key, query_str)
    query = "?type=json&#{query_key}=#{query_str}"
    puts "query: #{query}"
    query
  end
end
