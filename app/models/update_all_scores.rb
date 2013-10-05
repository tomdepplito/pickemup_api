require 'torquebox-messaging'
class UpdateAllScores
  include Scoring
  def initialize
    #@queue = TorqueBox.fetch('/queues/update_all_scores')
  end

  def start
    #@queue.publish('')
    #if @queue.receive(:timeout => 5_000)
    #end
    puts "Starting update all scores thread"
    Thread.new do
      listings = JobListing.all.query(:live? => true)
      preferences = Preference.all
      listings.each do |job_listing|
        preferences.each do |preference|
          set_score(job_listing, preference)
        end
      end
      true
    end
    puts "done with thread"
  end

  def update_all_scores
    listings = JobListing.all.query(:live? => true)
    preferences = Preference.all
    listings.each do |job_listing|
      preferences.each do |preference|
        set_score(job_listing, preference)
      end
    end
    true
  end
end
