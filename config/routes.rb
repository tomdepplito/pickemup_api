PickemupApi::Application.routes.draw do
  #Preferences
  post '/preferences/update' => 'preferences#update'
  get '/preferences/retrieve' => 'preferences#retrieve'
  post '/preferences/create' => 'preferences#create'
  #Job Listings
  post '/job_listings/update' => 'job_listings#update'
  get '/job_listings/retrieve' => 'job_listings#retrieve'
  post '/job_listings/create' => 'job_listings#create'
end
