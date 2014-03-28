source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'rack-cors', :require => 'rack/cors'


group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem "better_errors"
  gem "debugger"
  gem 'rspec-rails', '2.13.1'
  gem 'capybara', '2.1.0'
  gem 'selenium-webdriver', '2.35.1'
  gem 'launchy' #for save_and_open method, debugging
end

group :production do 
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

# for multiple forms
gem "nested_form"

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# to use attr_accessible
gem 'protected_attributes'

# user authentication solution See: https://github.com/plataformatec/devise
gem 'devise'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
