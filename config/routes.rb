PickemupApi::Application.routes.draw do
  post '/preferences/update_preference' => 'preferences#update_preference'
  get '/preferences/update_preference' => 'preferences#update_preference'
end
