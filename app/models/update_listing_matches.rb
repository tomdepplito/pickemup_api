require 'torquebox-messaging'
class UpdateListingMatches
  include Scoring
  def initialize
  end

  def start(preference_id)
    puts "Starting update listing thread"
    Thread.new do
      preference = Preference.find("preference_id: #{preference_id}")
      puts "preference: #{preference}"
      if preference
        query = {:live? => true, :us_citizen => preference.us_citizen, :remote => preference.remote, :fulltime => preference.fulltime}
        #listings = JobListing.all.query(query)
        listings = JobListing.all
        puts "listing count: #{listings.count}"
        if listings.count > 0
          all_listings = listings.to_a
          all_listings.each do |job_listing|
            if ((job_listing.locations & preference.locations).count >= 1) && ((job_listing.skills & preference.skills).count >= 1)
              puts "Updating listing scores"
              set_score(job_listing, preference)
            end
          end
        end
      end
      true
    end
  end
end
