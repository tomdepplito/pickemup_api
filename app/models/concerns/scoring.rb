module Scoring
  extend self

  #def set_score(job_listing, preference)
  def set_score(job_listing=nil, preference=nil)
    #algorithm = Algorithm.new(preference, job_listing)
    #key = "score.#{job_listing.job_listing_id}.#{preference.preference_id}"
    #$scores.set(key, {'score' => algorithm.score}.to_json)
    $scores.set("testing", "THIS IS WORKING")
  end
end
