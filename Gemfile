source 'http://rubygems.org'

gem 'rake', '0.8.7'

gem 'rails', '3.1.3'
gem 'thin'

gem 'sqlite3'

gem 'mongoid'
gem 'bson_ext'
gem 'delayed_job'
gem 'geocoder'
gem 'remotipart', '~> 1.0'
gem 'jquery-rails'

group :production do
  gem 'pg'
  #gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :development, :test do 
  gem 'linecache19'
  gem 'capybara',">= 1.0.0"
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'fuubar'
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem "guard-rspec"
  gem 'growl_notify'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'factory_girl_rails'
  gem 'launchy'
  gem "ruby-debug19"
  gem "selenium-client"
  gem 'turn', '0.8.2', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end


