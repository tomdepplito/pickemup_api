require 'torquebox-messaging'
class UpdatePreferenceMatches
  include Scoring
  def initialize
    @queue = TorqueBox.fetch('/queues/update_preference_matches')
  end

  def start(job_listing_id)
    @queue.publish(job_listing_id)
    if @queue.receive(:timeout => 5_000)
      update_relevant_preference_matches(job_listing_id)
      true
    end
  end

  def update_revelant_preference_matches(job_listing_id)
    job_listing = JobListing.find("job_listing_id: #{job_listing_id}")
    if job_listing
      query = {:us_citizen => preference.us_citizen, :remote => preference.remote, :fulltime => preference.fulltime}
      preferences = Preference.all.query(query)
      if preferences.count > 0
        all_preferences = preferences.to_a
        all_preferences.each do |preference|
          if ((preference.locations & job_listing.locations).count >= 1) && ((preference.skills & preference.skills).count >= 1)
            set_score(job_listing, preference)
          end
        end
      end
    end
  end
end
