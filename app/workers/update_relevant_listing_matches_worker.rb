# When a preference changes, this worker runs to update the scores for all relevant job listings
class UpdateRelevantListingMatchesWorker
  include Sidekiq::Worker

  def perform(preference_id)
    preference = Preference.find("preference_id: #{preference_id}")
    ScoreUpdater.update_relevant_listing_matches(preference) if preference
  end
end

