source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'sidekiq'
gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'
gem 'russian'
gem 'clockwork'

gem 'rest-client'

gem 'slim'
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', :require => nil

#gem 'whenever', :require => false

gem 'execjs'
gem 'therubyracer', :platform => :ruby
gem 'therubyrhino', :platform => :jruby

gem 'vk-ruby', '0.9.2'
gem 'rb-readline'
gem 'yajl-ruby', :platform => :ruby

gem 'sass-rails', '~> 3.2'
gem 'bootstrap-sass', '~> 2.3.1.0'

group :development do
  gem 'sqlite3', :platform => :ruby
  gem 'activerecord-jdbcsqlite3-adapter', :platform => :jruby
#  gem 'mysql2'
end

group :production do
  gem 'mysql2', :platform => :ruby
  gem 'activerecord-jdbcmysql-adapter', :platform => :jruby
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'debugger'
