# Helper code for the application
module Yale
  require 'json'
  require 'singleton'

  # Proxy for CardSwipr API
  class CardSwiprApiProxy
    include Singleton

    def initialize
      Rails.logger.info("Yale::CardSwiprApiProxy#initialize API URL: #{Rails.configuration.custom.cardSwiprApiURL})")

      @cert = get_cert
      @key = get_key

    end

    def get_cert
      certfile = Rails.application.secrets.ssl_client_certificate
      Rails.logger.info("CardSwiprApiProxy#get_cert path: #{certfile}")
      OpenSSL::X509::Certificate.new(File.read(certfile))
    rescue
      Rails.logger.fatal("ERROR Failed to load cert file at #{certfile}")
      return nil
    end

    def get_key
      keyfile = Rails.application.secrets.ssl_client_key
      Rails.logger.info("CardSwiprApiProxy#get_key path: #{keyfile}")
      OpenSSL::PKey::RSA.new(File.read(keyfile))
    rescue
      Rails.logger.fatal("ERROR Failed to load key file at #{keyfile}")
      return nil
    end

    # Send query to Layer7 and return the response.
    def send(query)
      url = "#{Rails.configuration.custom.cardSwiprApiURL}#{query}"
      Rails.logger.debug("CardSwiprApiProxy#send URL: #{url}")

      rsrc = RestClient::Resource.new(
        url,
        headers: { accept: :json },
        ssl_client_cert: @cert,
        ssl_client_key: @key,
        verify_ssl: OpenSSL::SSL::VERIFY_PEER)

      response = rsrc.get
      Rails.logger.debug("CardSwiprApiProxy#send raw response: #{response}")
      JSON.parse(response)
    rescue => e
      Rails.logger.error("ERROR CardSwiprApiProxy#send url: #{url} - #{e.class} - #{e}")
      nil
    end
  end
end
