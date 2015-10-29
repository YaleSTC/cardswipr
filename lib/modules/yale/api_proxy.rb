# Helper code for the application
module Yale
  require 'json'
  require 'singleton'

  # Proxy for the Layer 7 API
  class ApiProxy
    include Singleton

    def initialize
      Rails.logger.info("Yale::ApiProxy#initialize API URL: #{Rails.configuration.custom.apiURL})")

      @cert = get_cert
      @key = get_key

    end

    def get_cert
      certfile = Rails.application.secrets.ssl_client_certificate
      Rails.logger.info("ApiProxy#get_cert path: #{certfile}")
      OpenSSL::X509::Certificate.new(File.read(certfile))
    rescue
      Rails.logger.fatal("ERROR Failed to load cert file at #{certfile}")
      return nil
    end

    def get_key
      keyfile = Rails.application.secrets.ssl_client_key
      Rails.logger.info("ApiProxy#get_key path: #{keyfile}")
      OpenSSL::PKey::RSA.new(File.read(keyfile))
    rescue
      Rails.logger.fatal("ERROR Failed to load key file at #{keyfile}")
      return nil
    end

    # Send query to Layer7 and return the response.
    def send(query)
      url = "#{Rails.configuration.custom.apiURL}#{query}"
      Rails.logger.debug("ApiProxy#send url: #{url}")

      rsrc = RestClient::Resource.new(
        url,
        headers: { accept: :json },
        ssl_client_cert: @cert,
        ssl_client_key: @key,
        verify_ssl: OpenSSL::SSL::VERIFY_PEER)

      JSON.parse(rsrc.get())
    rescue
      Rails.logger.error("ERROR w/ request: #{url}")
      nil
    end
  end
end
