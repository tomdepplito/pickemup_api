class UpdateAllScores
  include Scoring

  def update_all_scores
    listings = JobListing.all.query(:live? => true)
    preferences = Preference.all
    listings.each do |job_listing|
      preferences.each do |preference|
        set_score(job_listing, preference)
      end
    end
  end
end
