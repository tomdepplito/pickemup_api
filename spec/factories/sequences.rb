FactoryGirl.define do
  sequence(:guid)    { |n| "key_#{n}" }
  sequence(:random_id) {|n| @random_ids ||= (1..1000000).to_a.shuffle; @random_ids[n] }
end

