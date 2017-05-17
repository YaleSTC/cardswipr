# Helper code for the application
module Yale
  require 'json'
  require 'singleton'

  # Proxy for CardSwipr API
  class CardSwiprApiProxy
    include Singleton

    def initialize
      @username, @password = get_credentials
    end

    def get_credentials
      file_path = Rails.application.secrets.api_credentials_path
      Rails.logger.info("CardSwiprApiProxy#get_credentials path: #{file_path}")
      parsed = JSON.parse(File.read(file_path))
      return parsed['username'], parsed['password']
    rescue Exception => e
      Rails.logger.fatal("ERROR Failed to load user info file at #{file_path} - #{e.message}")
      Rails.logger.fatal(e.backtrace.inspect)
      return [nil, nil]
    end

    # Send query to Layer7 and return the response.
    def send(query)
      url = "#{Rails.configuration.custom.cardSwiprApiURL}?outputformat=json&#{query}"
      Rails.logger.info("CardSwiprApiProxy#send_with_basic_auth URL: #{url}")
      @rsrc = RestClient::Resource.new(url,
        user: @username,
        password: @password,
        headers: { accept: :json }
      )
      response = @rsrc.get()
      response_obj = JSON.parse(response.to_str)
      response_obj['ServiceResponse']['Record']
    rescue RestClient::Exception => e
      Rails.logger.error("CardSwiprApiProxy#send_with_basic_auth RestClient::Exception #{e}")
      raise CustomError.new(7000 + e.response.code, "Could not find the person")
    rescue => e
      Rails.logger.error("CardSwiprApiProxy#send_with_basic_auth error: #{e}")
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
