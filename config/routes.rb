Rails.application.routes.draw do
  root to: 'charts#index'
  post '/charts', to: 'charts#create'
  get '/batch' => 'batches#index', as: :batch
  get 'batch_file', to: 'batches#batch_file', as: :batch_file
  post '/batches', to: 'batches#create', as: :batches
  post '/batch_file_gen', to: 'batches#generate', as: :batch_file_gen
end
