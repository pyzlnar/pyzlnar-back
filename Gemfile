source 'https://rubygems.org'

ruby '2.4.0'

# Platform / System Gems
gem 'rails', '~> 5.0.1'
gem 'puma', '~> 3.0'
gem 'pg'

# Utilities
gem 'pry-rails'

group :development do
  # Deploy
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'

  # Lint
  gem 'rubocop', require: false

  # Spring
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Testing
group :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl'
end
