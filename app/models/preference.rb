class Preference < Neo4j::Rails::Model
  include PreferenceConstants

  property :locations, type: String, default: [] #Serialized Array
  property :skills, type: String, default: [] #Serialized Array
  property :us_citizen, type: :boolean, default: false
  property :remote, type: :boolean, default: false
  property :fulltime, type: :boolean, default: false
  property :user_id, type: :string, index: :exact, unique: true
  property :preference_id, type: :string, index: :exact, unique: true
  property :healthcare, type: :boolean, default: false
  property :dental, type: :boolean, default: false
  property :vision, type: :boolean, default: false
  property :life_insurance, type: :boolean, default: false
  property :vacation_days, type: :boolean, default: false
  property :equity, type: :boolean, default: false
  property :bonuses, type: :boolean, default: false
  property :retirement, type: :boolean, default: false
  property :open_source, type: :boolean, default: false
  property :expected_salary, type: :fixnum
  property :potential_availability, type: :fixnum
  property :work_hours, type: :fixnum
  property :company_size, type: :string, default: [] #Serialized Array
  property :industries, type: :string, default: [] #Serialized Array
  property :position_titles, type: :string, default: [] #Serialized Array
  property :company_types, type: :string, default: [] #Serialized Array
  property :perks, type: :string, default: [] #Serialized Array
  property :practices, type: :string, default: [] #Serialized Array
  property :experience_levels, type: :string, default: [] #Serialized Array
  property :willing_to_relocate, type: :boolean, default: false

  validates_presence_of :user_id

  validates_presence_of :preference_id
  validates_uniqueness_of :preference_id

  COMPANY_SIZE_RANGES = {'1-10 Employees' => 1..10, '11-50 Employees' => 11..50, '51-200 Employees' => 51..200, '201-500 Employees' => 201..500, '501+ Employees' => 501..Float::INFINITY}

  def user
    User.find("user_id: #{self.user_id}")
  end
end
