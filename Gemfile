source 'https://rubygems.org'

gem 'rails', '4.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'haml-rails'

gem 'bootstrap-sass'

gem 'activeadmin', github: 'gregbell/active_admin' #, branch: 'rails4'
gem 'ransack' #,              github: 'ernie/ransack',         branch: 'rails-4'
gem 'formtastic' #,          github: 'justinfrench/formtastic'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'sidekiq'
gem 'capistrano-sidekiq'

#gem "meta_search"
gem 'russian'
gem 'clockwork'
gem 'clockworkd'
gem 'daemons'

gem 'rest-client'

gem 'slim'
# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', :require => nil

#gem 'whenever', :require => false

gem 'execjs'
gem 'therubyracer', :platform => :ruby

gem 'vk-ruby', '0.9.2'
gem 'rb-readline'
gem 'yajl-ruby', :platform => :ruby


group :development do
  gem 'sqlite3', :platform => :ruby
  gem 'quiet_assets'

  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false

  gem 'capistrano-rvm',   '~> 0.1', require: false
#  gem 'mysql2'
end

group :production do
  gem 'mysql2', :platform => :ruby
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

end

gem 'jquery-rails'

gem 'capistrano', '~> 3.0', require: false, group: :development
