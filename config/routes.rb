PickemupApi::Application.routes.draw do
  post '/preferences/update_preference' => 'preferences#update_preference'
  get '/preferences/retrieve_preferences' => 'preferences#retrieve_preferences'
  post '/preferences/create_preference' => 'preferences#create_preference'
end
