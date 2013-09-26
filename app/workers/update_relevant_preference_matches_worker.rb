# When a job listing changes, this worker runs to update the scores for all relevant preferences
class UpdateRelevantPreferenceMatchesWorker
  include Sidekiq::Worker

  def perform(listing_id)
    listing = JobListing.find("job_listing_id: #{listing_id}")
    ScoreUpdater.update_relevant_preference_matches(listing) if listing
  end
end

