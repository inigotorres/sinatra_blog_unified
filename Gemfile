source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.5'

gem 'pony'
gem 'data_mapper'
gem 'dm-sqlite-adapter', '~> 1.2.0'

gem 'foreman', '~> 0.62.0', require: false

group :development do
  gem 'thin', '~> 1.6.3'
end

group :test do
  gem 'rspec', '~> 3.1.0'
  gem 'rack-test', '~> 0.6.2'
end

group :production do
  gem 'unicorn', '~> 4.8.2'
  gem 'newrelic_rpm', '~> 3.7.3.204'
end
