source "https://rubygems.org"

ruby File.read(".ruby-version").chomp

gem "rails", "4.2.11.3"

gem "therubyracer", "0.12.3"
gem "devise", "4.7.1"
gem "devise_invitable"
gem "redcarpet"
gem "figaro", git: "https://github.com/laserlemon/figaro"
gem "active_model_serializers", "~> 0.8.1"
gem "kaminari"
gem "public_activity"
gem "sass-rails"
gem "less-rails"
gem "uglifier"
gem "coffee-rails"
gem "jquery-rails"
gem "haml-rails"

group :test do
  gem "factory_girl_rails", require: false
  gem "timecop"
  gem "fivemat"
end

group :test, :development do
  gem "rspec-rails"
  gem "sqlite3"
end

group :development do
  gem "letter_opener"
  gem "better_errors"
  gem "rack-mini-profiler", "~> 0.10.1"
  gem "pry-rails"
end

group :production do
  gem "pg"
end

source "https://rails-assets.org" do
  gem "rails-assets-select2", "3.4.5"
  gem "rails-assets-strapless", "3.0.3"
end
