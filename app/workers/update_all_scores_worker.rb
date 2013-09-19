# This worker should run nightly to update all scores
class UpdateAllScoresWorker
  include Sidekiq::Worker

  def perform
    ScoreUpdater.update_all_scores
  end
end

