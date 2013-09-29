class ScoreUpdater
  def self.update_all_scores
    binding.pry
    listings = JobListing.all.query(:live? => true)
    preferences = Preference.all
    listings.each do |job_listing|
      preferences.each do |preference|
        set_score(job_listing, preference)
      end
    end
  end

  def self.update_relevant_listing_matches(preference)
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

  def self.update_revelant_preference_matches(job_listing)
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

  def self.set_score(job_listing, preference)
    algorithm = Algorithm.new(preference, job_listing)
    key = "score.#{job_listing.job_listing_id}.#{preference.preference_id}"
    $redis.set(key, {'score' => algorithm.score}.to_json)
  end
end
