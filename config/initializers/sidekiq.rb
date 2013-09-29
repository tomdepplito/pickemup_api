Sidekiq.configure_server do |config|
  config.redis = { :url => Rails.env.development? ? "redis://localhost:6379/" : ENV["REDISTOGO_URL"] || "redis://localhost:6379/" }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => Rails.env.development? ? "redis://localhost:6379/" : ENV["REDISTOGO_URL"] || "redis://localhost:6379/" }
end
