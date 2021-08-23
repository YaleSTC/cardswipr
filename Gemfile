source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.4.1'

gem 'administrate', '~> 0.16.0'
gem 'bootsnap', '>= 1.4.5', require: false
gem 'devise', '~> 4.7.0'
gem 'devise_cas_authenticatable', '~> 1.10.3'
gem 'dotenv-rails', '~> 2.7.5'
gem 'ffaker', '~> 2.2'
gem 'font-awesome-rails', '~> 4.7.0'
gem 'high_voltage', '~> 3.1.0'
gem 'httparty', '~> 0.16.4'
gem 'jbuilder', '~> 2.5'
gem 'kaminari', '~> 1.1'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 4.3'
gem 'pundit', '~> 1.1.0'
gem 'shoulda-matchers', '~> 3.1.3'
gem 'simple_form', '~> 5.0.0'
gem 'sprockets', '~> 3.7.2'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.2'

group :development, :test do
  gem 'bundler-audit', '~> 0.6.1'
  gem 'byebug', '~> 10.0.2', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'pry', '~> 0.12.2'
  gem 'pry-byebug', '~> 3.6.0'
  gem 'rspec-rails', '~> 3.8.1'
  gem 'rubocop', '~> 0.63.0', require: false
  gem 'rubocop-rspec', '~> 1.31.0', require: false
  gem 'webmock', '~> 3.5.1'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.31.0'
  gem 'selenium-webdriver', '~> 3.142.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
