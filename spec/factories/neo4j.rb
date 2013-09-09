FactoryGirl.define do
  factory :job_listing do
    locations []
    remote false
    us_citizen false
    skills []
    fulltime false
    listing_id { generate(:random_id) }
    active false
    expiration_time Time.now + 1.month
  end

  factory :preference do
    locations []
    remote false
    us_citizen false
    skills []
    fulltime false
    user_id { generate(:random_id) }
  end
end
