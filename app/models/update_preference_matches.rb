class UpdatePreferenceMatches
  include Scoring

  def start(job_listing_id)
    job_listing = JobListing.find("job_listing_id: #{job_listing_id}")
    puts "job listing: #{job_listing}"
    if job_listing
      query = {:us_citizen => job_listing.us_citizen, :remote => job_listing.remote, :fulltime => job_listing.fulltime}
      #preferences = Preference.all.query(query)
      preferences = Preference.all
      puts "preference count: #{preferences.count}"
      if preferences.count > 0
        all_preferences = preferences.to_a
        all_preferences.each do |preference|
          if ((preference.locations & job_listing.locations).count >= 1) && ((preference.skills & preference.skills).count >= 1)
            set_score(job_listing, preference)
          end
        end
      end
    end
    true
  end
end
