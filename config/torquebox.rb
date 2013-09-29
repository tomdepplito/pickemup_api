TorqueBox.configure do
  queue '/queues/update_all_scores'
  queue '/queues/update_listing_matches'
  queue '/queues/update_preference_matches'
end
