source 'https://rubygems.org'
ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.1'

#RAILS STUFF
gem 'rails', '4.0.0.rc1'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 1.2'

#JAVASCRIPT
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

#WEB SERVERS
gem "puma", "~> 2.0.0.b7"

#QUEUES
gem "resque", "~> 1.25.1"

#OTHER
gem 'redis'

group :production do
  #HEROKU
  gem 'rails_12factor'
end

group :test, :development do
  gem 'pry' #debugging
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fakeredis', require: 'fakeredis/rspec'
end

group :doc do
  gem 'sdoc', require: false
end

platform :ruby do
  gem 'pg'
  gem 'pg-hstore'
end

platform :jruby do
  gem 'therubyrhino'
  gem 'activerecord-jdbcsqlite3-adapter', :group => :development
  gem 'activerecord-jdbcpostgresql-adapter', :group => :production
  #gem 'activerecord-jdbcsqlite3-adapter', '1.3.0.beta1'
  gem 'neo4j', git: 'https://github.com/andreasronge/neo4j.git', branch: 'rails4'
  gem 'neo4j-admin'
end
