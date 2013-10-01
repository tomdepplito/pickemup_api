if Rails.env.production?
  #uri = URI.parse(ENV["REDISTOGO_URL"])
  uri = URI.parse("redis://redistogo:df5e1c4ef20ecf7bbbcb97f6be38a665@tarpon.redistogo.com:9804/")
else
  uri = URI.parse("redis://localhost:6379/")
end
$scores = Redis.new(host: uri.host, port: uri.port, password: uri.password)
