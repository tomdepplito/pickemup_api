class Preference < Neo4j::Rails::Model
  property :locations, type: String #Serialized Array
  property :skills, type: String #Serialized Array
  property :us_citizen, type: :boolean
  property :remote, type: :boolean
  property :user_id, type: :string, index: :exact, unique: true
end
