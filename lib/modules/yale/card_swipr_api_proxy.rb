# Helper code for the application
module Yale
  require 'json'
  require 'singleton'

  # Proxy for CardSwipr API
  class CardSwiprApiProxy
    include Singleton

    def initialize
      @username = Rails.application.secrets.id_api_username;
      @password = Rails.application.secrets.id_api_password;
    end

    # Send query to Layer7 and return the response.
    def send(query)
      url = "#{Rails.configuration.custom.cardSwiprApiURL}?outputformat=json&#{query}"
      Rails.logger.info("CardSwiprApiProxy#send URL: #{url}")
      @rsrc = RestClient::Resource.new(url,
        user: @username,
        password: @password,
        headers: { accept: :json }
      )
      response = @rsrc.get()
      response_obj = JSON.parse(response.to_str)
      response_obj['ServiceResponse']['Record']
    rescue RestClient::Exception => e
      Rails.logger.error("CardSwiprApiProxy#send RestClient::Exception #{e}")
      raise CustomError.new(7000 + e.response.code, "Could not find the person")
    rescue => e
      Rails.logger.error("CardSwiprApiProxy#send error: #{e}")
      raise e
    end

    def find_by_upi(upi)
      send("upi=#{upi}")
    end

    def find_by_netid(netid)
      send("netid=#{netid}")
    end

    def find_by_email(email)
      send("email=#{email}")
    end

    def find_by_prox_num(num)
      send("proxNumber=#{num}")
    end

    def find_by_mag_stripe_num(num)
      send("magstripenumber=#{num}")
    end
  end
end
