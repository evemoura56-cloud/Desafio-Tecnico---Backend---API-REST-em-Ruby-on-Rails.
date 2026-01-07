source "https://rubygems.org"

ruby "3.3.10"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

gem 'redis', '~> 5.2'
gem 'sidekiq', '~> 7.2', '>= 7.2.4'
gem 'sidekiq-scheduler', '~> 5.0', '>= 5.0.3'
gem 'sidekiq-cron'

gem 'guard'
gem 'guard-livereload', require: false


group :development, :test do
  gem "rspec-rails", "~> 6.1"
  gem "factory_bot_rails", "~> 6.4"
  gem 'shoulda-matchers', '~> 6.0'
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
