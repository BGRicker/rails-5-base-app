#CLIENT
Sidekiq.configure_client do |config|
  if Rails.env.development?
    config.redis = {
      size: 3,
      url: ENV['REDIS_PROVIDER']
    }
  else
    config.redis = { size: 3 }
  end
end

#SERVER
Sidekiq.configure_server do |config|
  if Rails.env.development?
    config.redis = { size: 12, url: ENV['REDIS_PROVIDER'] }
  else
    config.redis = { size: 12 }
  end
end
