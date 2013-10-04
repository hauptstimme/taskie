source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', github: 'rails/rails'
gem 'devise'
gem 'redcarpet'

group :test do
  gem 'capybara'
  gem 'factory_girl_rails', require: false
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'letter_opener'
end

group :production do
  gem 'pg'
end

gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'turbolinks'
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'
gem 'controller_scaffolder', github: 'lacrosse/controller_scaffolder'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
