Rails.application.routes.draw do
  root to: 'charts#index'
  post '/charts', to: 'charts#create'
  get '/batch' => 'batches#index', as: :batch
  post '/batches', to: 'batches#create', as: :batches
end
