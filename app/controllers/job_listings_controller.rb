class JobListingsController < ApplicationController
  require 'string'
  respond_to :json, :html
  def update
    listing = JobListing.find("listing_id: #{create_update_params['listing_id']}")
    if listing && listing.update_attributes(create_update_params)
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
      @listing_ids = listings.map{ |listing| listing.listing_id }
      if @listing_ids.count > 0
        render json: @listing_ids
      else
        render text: "Action Failed", status: 500
      end
    else
      render text: "Action Failed", status: 500
    end
  end

  def create
    listing = JobListing.create(create_update_params)
    if listing && listing.save
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  def destroy
    listing = JobListing.find("listing_id: #{params['listing_id']}")
    if listing && listing.destroy
      render text: "OK", status: 200
    else
      render text: "Action Failed", status: 500
    end
  end

  private

  def create_update_params
    modified_params = {}
    params.require(:job_listing).permit!.each do |key, val|
      unless val.blank?
        if val.class.name == "String"
          modified_params.merge!(key => val.to_bool)
        elsif key =~ /location/
          modified_params.merge!('locations' => [val])
        elsif key =~ /acceptable_languages/
          modified_params.merge!('skills' => val)
        end
      end
    end
    modified_params
  end

  def initial_query_params
    search_params = {}
    params.require(:job_listing).permit!.each do |key, val|
      unless val.blank?
        search_params.merge!(key => val.to_bool) if val.class.name == "String"
      end
    end
    search_params
  end

  def array_query_params
    search_params = {"locations" => [], "skills" => []}
    params.require(:job_listing).permit!.each do |key, val|
      if key =~ /locations|skills/
        val.blank? ? search_params.merge!(key => []) : search_params.merge!(key => val)
      end
    end
    search_params
  end
end
