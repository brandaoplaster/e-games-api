# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.7"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "puma", "~> 5.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "cpf_cnpj", "~> 0.5.0"
gem "rack-cors"

gem "devise_token_auth", "~> 1.2", ">= 1.2.2"
gem "httparty", "~> 0.18.1"
gem "jbuilder", "~> 2.11", ">= 2.11.5"
gem "sidekiq", "~> 7.1", ">= 7.1.2"
gem "sidekiq-scheduler", "~> 5.0", ">= 5.0.3"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 4.1", ">= 4.1.2"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", "~> 0.21.2", require: false
  gem "simplecov_json_formatter", "~> 0.1.4", require: false

  gem "rubocop"
  gem "rubocop-github", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec"
  gem "ruby-lsp"
  gem "rufo"
end

group :development do
  gem "listen", "~> 3.3"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end
