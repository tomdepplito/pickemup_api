include TorqueBox
require 'torquebox-messaging'
class UpdatePreferenceMatches
  include Scoring
  def initialize
    #@queue = TorqueBox.fetch('/queues/update_preference_matches')
    #@queue = TorqueBox::Messaging::Queue.start("/queues/update_preferences_matches", :durable => false)
    puts "New update preference"
  end

  def start(job_listing_id)
    #@queue.publish(job_listing_id)
    #puts "queue publish: #{@queue}"
    #if @queue.receive(:timeout => 5_000)
    puts "Just before update preference Thread"
    Thread.new do
      puts "Start Thread"
      job_listing = JobListing.find("job_listing_id: #{job_listing_id}")
      puts "job listing: #{job_listing}"
      if job_listing
        query = {:us_citizen => job_listing.us_citizen, :remote => job_listing.remote, :fulltime => job_listing.fulltime}
        puts "Just before preference query - THIS MIGHT BREAK"
        #preferences = Preference.all.query(query)
        preferences = Preference.all
        if preferences.count > 0
          puts "Hey! This is still working!"
          all_preferences = preferences.to_a
          all_preferences.each do |preference|
        #    if ((preference.locations & job_listing.locations).count >= 1) && ((preference.skills & preference.skills).count >= 1)
              puts "Setting Score: #{set_score(job_listing, preference)}"
              puts "Score: #{$scores.get("score.#{job_listing.job_listing_id}.#{preference.preference_id}")}"
           # end
          end
        end
      end
      puts "Redis keys: #{$scores.keys}"
      true
    end
  end
end
