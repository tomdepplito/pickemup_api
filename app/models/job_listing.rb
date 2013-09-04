class JobListing < Neo4j::Rails::Model
  property :locations, type: String, default: [] #Serialized Array
  property :skills, type: String, default: [] #Serialized Array
  property :us_citizen, type: :boolean, default: false
  property :remote, type: :boolean, default: false
  property :fulltime, type: :boolean, default: false
  property :listing_id, type: :string, index: :exact, unique: true

  validates_presence_of :listing_id
  validates_uniqueness_of :listing_id
end
