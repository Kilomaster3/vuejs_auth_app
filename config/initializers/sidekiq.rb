Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://192.xxx.xxx.xx:6379/0' }
end
