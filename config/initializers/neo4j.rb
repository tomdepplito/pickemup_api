require 'neo4j'
module Neo4j
  class Railtie < ::Rails::Railtie
    initializer "neo4j.db.start", :after => "neo4j.start" do |app|
      Neo4j.start if app.config.neo4j.auto_start
    end
  end
end
