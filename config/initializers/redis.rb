uri = URI.parse(Rails.env.production? ? ENV["REDISTOGO_URL"] : "redis://localhost:6379/")
$scores = Redis.new(host: uri.host, port: uri.port, password: uri.password)
