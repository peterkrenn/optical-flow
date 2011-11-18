source 'http://rubygems.org'

gem 'rails', '3.1.2'

gem 'sqlite3'
gem 'carrierwave'
gem 'fog'

gem 'decent_exposure'

gem 'haml'
gem 'jquery-rails'

gem 'resque'

group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'ruby-debug19'
  gem 'rspec-rails'
  gem 'fabrication'

  if RUBY_PLATFORM =~ /darwin/
    gem 'guard-pow'
  end
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
    gem 'rb-fsevent'
    gem 'growl'
  end
end
