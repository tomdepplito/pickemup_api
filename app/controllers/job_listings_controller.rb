require 'torquebox-messaging'
class JobListingsController < ApplicationController
  require 'string'
  respond_to :json, :html
  def update
    listing = JobListing.find("job_listing_id: #{params['job_listing']['job_listing_id']}")
    if listing && listing.update_attributes(create_params)
      UpdatePreferenceMatches.new.start(params['job_listing']['job_listing_id'])
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def retrieve
    listings = JobListing.all.query(initial_query_params)
    if listings.count > 0
      all_listings = listings.to_a
      all_listings.select! do |listing|
        ((listing.locations & array_query_params['locations']).count >= 1) && ((listing.skills & array_query_params['skills']).count >= 1)
      end
      @listing_ids = all_listings.map{ |listing| listing.job_listing_id }
      if @listing_ids.count > 0
        render json: @listing_ids
      else
        render text: "Action Failed", status: 500
      end
    else
      render json: []
    end
  end

  def create
    listing = JobListing.create(create_params)
    if listing && listing.save
      UpdatePreferenceMatches.new.start(params['job_listing']['job_listing_id'])
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def destroy
    listing = JobListing.find("job_listing_id: #{params['job_listing']['job_listing_id']}")
    if listing && listing.destroy
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def update_scores
    if UpdateAllScores.new.start
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  private

  def create_params
    modified_params = params.require(:job_listing).permit!
    modified_params.merge('expiration_time' => DateTime.parse(params['job_listing']['expiration_time']))
  end

  def initial_query_params
    search_params = {:live? => true}
    search_params.merge!(params.require(:job_listing).permit!.select { |key, val| val.class.name != "Array"})
  end

  def array_query_params
    search_params = {"locations" => [], "skills" => []}
    params.require(:job_listing).permit!.each do |key, val|
      search_params.merge!(key => val) if val.class.name == 'Array'
    end
    search_params
  end
end
