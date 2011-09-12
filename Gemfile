source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'sqlite3'
gem 'squeel'
gem 'carrierwave'

gem 'decent_exposure'

gem 'haml'
gem 'jquery-rails'

gem 'resque'

group :assets do
  gem 'sass-rails', '~> 3.1.0'
  gem 'coffee-rails', '~> 3.1.0'
  gem 'uglifier'
end

group :development, :test do
  gem 'ruby-debug19'
  gem 'rspec-rails'
  gem 'fabrication'
end

group :test do
  gem 'shoulda-matchers'
  gem 'webrat'

  gem 'fuubar'
  gem 'spork', '0.9.0.rc9'

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'

  if RUBY_PLATFORM =~ /darwin/
    gem 'guard-pow'
    gem 'rb-fsevent'
    gem 'growl_notify'
  end
end
