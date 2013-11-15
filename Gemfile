source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.1'
gem 'devise'
gem 'devise_invitable'
gem 'redcarpet'
gem 'figaro'
gem 'coveralls', require: false
gem 'active_model_serializers'

group :test do
  # gem 'capybara'
  gem 'factory_girl_rails', require: false
  gem 'timecop'
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
gem 'kaminari'
gem 'twitter-bootstrap-rails', github: 'seyhunak/twitter-bootstrap-rails', branch: 'bootstrap3'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end
