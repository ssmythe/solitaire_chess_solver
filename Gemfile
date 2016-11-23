source 'https://rubygems.org'

if RUBY_PLATFORM =~ /(win32|w32)/
  gem "win32console", '1.3.0'
end

gem 'logger'
gem 'simplecov'

group :development do
  gem 'guard'
  gem 'guard-cucumber'
end

group :test do
  gem 'cucumber'
  gem 'rake'
  gem 'rspec'
  gem 'rubocop'
  gem 'metric_fu'
end
