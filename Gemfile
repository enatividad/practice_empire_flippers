source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.7'

# CORE
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'pg', '~> 1.1'
gem 'redis', '~> 4.3', '>= 4.3.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false

gem 'faraday', '1.4.2'
gem 'sidekiq', '~> 6.2', '>= 6.2.1'
gem 'sidekiq-scheduler', '~> 3.1'

group :development, :test do
  gem 'pry-rails'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'vcr', '~> 6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
