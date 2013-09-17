class JobListing < Neo4j::Rails::Model
  property :locations, type: String, default: [] #Serialized Array
  property :skills, type: String, default: [] #Serialized Array
  property :us_citizen, type: :boolean, default: false
  property :remote, type: :boolean, default: false
  property :fulltime, type: :boolean, default: false
  property :job_listing_id, type: :string, index: :exact, unique: true
  property :active, type: :boolean, deafult: false
  property :expiration_time, type: DateTime, default: Time.now
  property :company_id, type: :string
  property :job_title, type: :string
  property :job_description, type: :string
  property :salary_range_high, type: :fixnum
  property :salary_range_low, type: :fixnum
  property :vacation_days, type: :fixnum
  property :equity, type: :string
  property :bonuses, type: :string
  property :fulltime, type: :boolean, default: false
  property :remote, type: :boolean, default: false
  property :hiring_time, type: :fixnum
  property :tech_stack_id, type: :string
  property :healthcare, type: :boolean
  property :dental, type: :boolean
  property :vision, type: :boolean
  property :life_insurance, type: :boolean
  property :retirement, type: :boolean
  property :estimated_work_hours, type: :fixnum
  property :practices, type: :string, default: [] #Serialized Array
  property :acceptable_languages, type: :string, default: [] #Serialized Array
  property :special_characteristics, type: :string, default: [] #Serialized Array
  property :experience_levels, type: :string, default: [] #Serialized Array
  property :perks, type: :string, default: [] #Serialized Array
  property :position_titles, type: :string, default: [] #Serialized Array

  validates_presence_of :job_listing_id
  validates_uniqueness_of :job_listing_id

  validates_presence_of :company_id

  def company
    Company.find("company_id: #{self.company_id}")
  end

  def salary_range
    (self.salary_range_low..self.salary_range_high)
  end

  def live?
    return false if Time.now > self.expiration_time
    self.active
  end
end
