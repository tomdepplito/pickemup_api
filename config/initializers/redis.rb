if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"])
else
  uri = URI.parse("redis://localhost:6379/")
end
$scores = Redis.new(host: uri.host, port: uri.port, password: uri.password)
