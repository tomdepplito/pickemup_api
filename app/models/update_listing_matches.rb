require 'torquebox-messaging'
class UpdateListingMatches
  include Scoring
  def initialize
    @queue = TorqueBox.fetch('/queues/update_listing_matches')
  end

  def start(preference_id)
    @queue.publish(preference_id)
    if @queue.receive(:timeout => 5_000)
      update_relevant_listing_matches(preference_id)
      true
    end
  end

  def update_relevant_listing_matches(preference_id)
    preference = Preference.find("preference_id: #{preference_id}")
    if preference
      query = {:live? => true, :us_citizen => preference.us_citizen, :remote => preference.remote, :fulltime => preference.fulltime}
      listings = JobListing.all.query(query)
      if listings.count > 0
        all_listings = listings.to_a
        all_listings.each do |job_listing|
          if ((job_listing.locations & preference.locations).count >= 1) && ((job_listing.skills & preference.skills).count >= 1)
            set_score(job_listing, preference)
          end
        end
      end
    end
  end
end
