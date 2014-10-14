# This class is only used to connect to the Yale Card-Swipe API
# and return the UPI
module YaleCardSwipe
  require 'httparty'
  YALE_API_KEY = Rails.application.secrets.yale_api_portal
  BASE_URI = 'https://gw-tst.its.yale.edu/soa-gateway/idcardlookup/getUpi?type=json&apikey=' + YALE_API_KEY + '&badgeId='


  # #lookup will convert a Yale ID's magnetic magstripe card-swipe number or prox card number
  # to UPI.
  # @param [String] accepts the magnetic card-swipe number from a Yale ID card, without leading/trailing characters
  # @return [String] upi = universal personal identification
  # @example
  #   YaleCardSwipe.lookup("1234567890")
  def self.lookup(query)
    response = HTTParty.get(BASE_URI + query)
    response_hash = JSON.parse(response.body)
    upi = response_hash["ServiceResponse"]["UPI"]
    upi
  end
end
