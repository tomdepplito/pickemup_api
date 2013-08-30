class JobListingsController < ApplicationController
  def update
    pref_params = params[:listing]
    listing = JobListing.find("listing_id: #{listing_params.slice!(:listing_id)}")
    if listing && listing.update_attributes(listing_params)
      respond_with 200
    else
      respond_with 500
    end
  end

  def retrieve
    listings = JobListing.all.query(:remote => query_params[:remote], :us_citizen => query_params[:us_citizen], :fulltime => query_params[:fulltime])
    if listings.count > 0
      listings.select! do |listing|
        ((listing.locations & query_params[:locations]).count >= 1) && ((listing.skills & query_params[:skills]).count >= 1)
      end
      @listing_ids = listings.map{ |listing| listing.listing_id }
      if @listing_ids.count > 0
        respond_with @listing_ids
      else
        respond_with 500
      end
    else
      respond_with 500
    end
  end

  def create
    listing = listing.create(listing_params)
    if listing && listing.save
      respond_with 200
    else
      respond_with 500
    end
  end

  private

  def listing_params
    params.require(:listing).permit!
  end

  def query_params
    params.require(:query).permit!
  end
end
