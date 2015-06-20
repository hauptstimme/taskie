source 'https://rubygems.org'

gem 'rails', '~> 4.1.0'

gem 'therubyracer'
gem 'devise', '~> 3.2.2'
gem 'devise_invitable'
gem 'redcarpet'
gem 'figaro', github: 'laserlemon/figaro'
gem 'coveralls', require: false
gem 'active_model_serializers', '~> 0.8.1'
gem 'kaminari'
gem 'public_activity'
gem 'sass-rails'
gem 'less-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'rugged', github: 'libgit2/rugged', submodules: true


group :test do
  gem 'factory_girl_rails', require: false
  gem 'timecop'
  gem 'fivemat'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'letter_opener'
  gem 'better_errors'
  gem 'rack-mini-profiler'
end

group :production do
  gem 'pg'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-strapless', '3.0.3'
  gem 'rails-assets-select2', '3.4.5'
end
