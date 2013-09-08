class JobListing < Neo4j::Rails::Model
  property :locations, type: String, default: [] #Serialized Array
  property :skills, type: String, default: [] #Serialized Array
  property :us_citizen, type: :boolean, default: false
  property :remote, type: :boolean, default: false
  property :fulltime, type: :boolean, default: false
  property :listing_id, type: :string, index: :exact, unique: true
  property :active, type: :boolean, deafult: false
  property :expiration_time, type: DateTime, default: Time.now

  validates_presence_of :listing_id
  validates_uniqueness_of :listing_id

  def live?
    return false if Time.now > self.expiration_time
    self.active
  end
end
