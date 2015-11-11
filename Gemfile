source 'https://rubygems.org'

gem 'rails', '4.2.3'
gem 'rails-api'
gem 'pg'
gem 'active_model_serializers'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use 'pry' as the rails console (instead of 'irb')
gem 'pry-rails', group: :development

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
  gem 'byebug'
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
