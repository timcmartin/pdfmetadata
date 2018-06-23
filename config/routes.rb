Rails.application.routes.draw do
  root to: 'charts#index'
  get '/batch' => 'charts#batch', as: :batch
  post '/charts', to: 'charts#create'
  post '/directory', to: 'charts#directory'
end
