# This class is only used to connect to the Yale oracle database
# that contains magstripe information, and return the UPI
class YaleCardSwipe < ActiveRecord::Base
  establish_connection "oracle"
  self.table_name = "people.ppl_identity_v"

  # #lookup will convert a Yale ID's magnetic card-swipe number to UPI.
  # @param [String] accepts the magnetic card-swipe number from a Yale ID card, without leading/trailing characters
  # @return [String] upi = universal personal identification
  # @example
  #   YaleCardSwipe.lookup("1234567890")
  def self.lookup(query)
    return YaleCardSwipe.find_by(id_card_number: query).yale_upi.to_i.to_s
  end
end
