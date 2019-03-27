# frozen_string_literal: true
auth_settings = if ENV['SMTP_AUTH'].present?
                  {
                    authentication: ENV.fetch('SMTP_AUTH').to_sym,
                    user_name: ENV.fetch('SMTP_USERNAME'),
                    password: ENV.fetch('SMTP_PASSWORD')
                  }
                else
                  {}
                end

SMTP_SETTINGS = {
  address: ENV.fetch('SMTP_ADDRESS'),
  domain: ENV.fetch('SMTP_DOMAIN'),
  port: ENV.fetch('SMTP_PORT'),
  enable_starttls_auto: true
}.merge(auth_settings).freeze
