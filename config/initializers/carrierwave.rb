FOG_CONFIG = YAML.load_file(File.join(ENV['HOME'], '.fog_config.yml'))['default']

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => FOG_CONFIG['aws_access_key_id'],
    :aws_secret_access_key => FOG_CONFIG['aws_secret_access_key'],
    :region => FOG_CONFIG['region']
  }
  config.fog_directory  = 'optical-flow'
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
