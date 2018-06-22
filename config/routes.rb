Rails.application.routes.draw do
  root to: 'charts#index'
  post '/charts', to: 'charts#create'
end
