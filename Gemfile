source 'https://rubygems.org'



### Rails Default Gems ###

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Use SCSS for stylesheets
gem "sass-rails", "~> 4.0.3"
gem 'bootstrap-sass'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development



### Custom Gems ###

# Authentication
gem 'rubycas-client', :git => 'git://github.com/rubycas/rubycas-client.git'

# Permissions
gem 'cancancan', '~> 1.9'

# Simple Form
gem 'simple_form'

# Database Gems
gem 'mysql2'
gem 'sqlite3'
gem 'ruby-oci8'
gem 'activerecord-oracle_enhanced-adapter', git: 'https://github.com/rsim/oracle-enhanced.git', branch: 'rails4'

# Service Now Gem
gem 'service_now'

# include LDAP
gem 'net-ldap'
gem 'yaleldap'

group :development do
  gem 'pry'
  # gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'pronto'
  gem 'pronto-rubocop'
  gem 'pronto-flay'
  gem 'pronto-brakeman'
  gem 'pronto-rails_best_practices'
  # gem 'pronto-reek'
end