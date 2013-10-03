class UpdateListingMatches
  include Scoring
  def start(preference_id)
    preference = Preference.find("preference_id: #{preference_id}")
    if preference
      query = {:live? => true, :us_citizen => preference.us_citizen, :remote => preference.remote, :fulltime => preference.fulltime}
      #listings = JobListing.all.query(query)
      listings = JobListing.all
      if listings.count > 0
        all_listings = listings.to_a
        all_listings.each do |job_listing|
          if ((job_listing.locations & preference.locations).count >= 1) && ((job_listing.skills & preference.skills).count >= 1)
            set_score(job_listing, preference)
          end
        end
      end
    end
    true
  end
end
