source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.1.2'

gem 'puma'
gem 'rack-canonical-host'
gem 'rails', '~> 4.2.3'
gem 'pg'

gem 'slim-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'simple_form'
gem 'uglifier'
gem 'autoprefixer-rails'
gem 'devise'

gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.15.35'

gem 'awesome_print'

group :production, :acceptance do
  gem 'rack-timeout'
  gem 'rails_stdout_logging'
  gem 'heroku_rails_deflate'
end

group :test do
  gem 'fuubar'
  gem 'capybara'
  gem 'capybara-email'
  gem 'poltergeist'
  #gem 'timecop'
  gem 'database_cleaner'
  gem 'simplecov'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'jasmine-rails'
  #gem 'cane'
  #gem 'morecane'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'foreman'
  gem 'launchy'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'guard', '~> 2'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'growl'
end
