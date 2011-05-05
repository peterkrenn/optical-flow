rails_env = ENV['RAILS_ENV'] || 'development'

resque_config = YAML.load_file(Rails.root.join('config', 'resque.yml'))
Resque.redis = resque_config[rails_env]

Dir[Rails.root.join('app', 'jobs', '*.rb')].each { |file| require file }
