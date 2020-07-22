source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'paint'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'whirly'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker'
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'simplecov', require: false
end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
