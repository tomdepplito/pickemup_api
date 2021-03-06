PickemupApi::Application.routes.draw do
  #Preferences
  post '/preferences/update' => 'preferences#update'
  get '/preferences/retrieve' => 'preferences#retrieve'
  post '/preferences/create' => 'preferences#create'
  post '/preferences/destroy' => 'preferences#destroy'
  post '/preferences/update_scores' => 'preferences#update_scores'
  #Job Listings
  post '/job_listings/update' => 'job_listings#update'
  get '/job_listings/retrieve' => 'job_listings#retrieve'
  post '/job_listings/create' => 'job_listings#create'
  post '/job_listings/destroy' => 'job_listings#destroy'
  post '/job_listings/update_scores' => 'job_listings#update_scores'
  #Companies
  post '/companies/update' => 'companies#update'
  post '/companies/create' => 'companies#create'
  post '/companies/destroy' => 'companies#destroy'
  #General Scoring
  get '/scores/update_all_scores' => 'scores#update_all_scores'
end
