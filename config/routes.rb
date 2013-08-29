PickemupApi::Application.routes.draw do
  #Preferences
  post '/preferences/update_preference' => 'preferences#update_preference'
  get '/preferences/retrieve_preferences' => 'preferences#retrieve_preferences'
  post '/preferences/create_preference' => 'preferences#create_preference'
  #Job Listings
  post '/job_listings/update_listing' => 'job_listings#update_listing'
  get '/job_listings/retrieve_listings' => 'job_listings#retrieve_listings'
  post '/job_listings/create_listing' => 'job_listings#create_listing'
end
