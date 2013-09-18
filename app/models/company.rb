class Company < Neo4j::Rails::Model
  property :company_id, type: :string, index: :exact, unique: true
  property :name, type: :string
  property :description, type: :string
  property :website, type: :string
  property :industry, type: :string
  property :num_employees, type: :string
  property :founded, type: :string
  property :acquired_by, type: :string
  property :tags, type: :string, default: [] #Serialized Array
  property :total_money_raised, type: :string
  property :competitors, type: :string, default: [] #Serialized Array
  property :size_definition, type: :string

  validates_presence_of :company_id
  validates_uniqueness_of :company_id
end
