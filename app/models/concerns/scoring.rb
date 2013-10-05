module Scoring
  extend self

  def set_score(job_listing, preference)
    algorithm = Algorithm.new(preference, job_listing)
    key = "score.#{job_listing.job_listing_id}.#{preference.preference_id}"
    $scores.set(key, {'score' => algorithm.score}.to_json)
  end
end
