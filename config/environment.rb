# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => ENV.fetch('CAS_BASE_URL')
)

# Initialize the Service Now gem
ServiceNow::Configuration.configure(sn_url: ENV.fetch('SN_INSTANCE'),
                                    sn_username: ENV.fetch('SN_USERNAME'),
                                    sn_password: ENV.fetch('SN_PASSWORD'))