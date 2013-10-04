class UpdateAllScores
  include Scoring

  def work
    $redis.set('testing', 'working')
    #listings = JobListing.all.query(:live? => true)
    #preferences = Preference.all
    #listings.each do |job_listing|
    #  preferences.each do |preference|
    #    set_score(job_listing, preference)
    #  end
    #end
  end
end
