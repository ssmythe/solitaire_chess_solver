source 'https://rubygems.org'

gem 'win32console', '1.3.0' if RUBY_PLATFORM =~ /(win32|w32)/

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
  # gem 'metric_fu'
  gem "rubycritic", :require => false
end
