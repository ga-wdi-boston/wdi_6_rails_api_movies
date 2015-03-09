source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'rails-api'
gem 'pg'
gem 'active_model_serializers',
    :git => 'git@github.com:rails-api/active_model_serializers.git',
    :branch => '0-8-stable'

gem 'currencies', :require => 'iso4217'

group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'capybara'
  gem 'rubocop'
  gem 'bullet'
  gem 'lol_dba'
  gem 'dotenv-rails'
  gem 'rspec-rails', '~> 3.1.0'
  gem 'rspec-its'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'codeclimate-test-reporter', require: nil
end

gem 'rack-cors', :require => 'rack/cors'

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
  gem 'rails_serve_static_assets'
end
