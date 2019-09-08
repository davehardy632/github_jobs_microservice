Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/users', to: 'users#index'
      post '/sessions', to: 'sessions#index'
      get '/listings', to: 'listings#index'
      get '/urban_area/scores', to: 'urban_area_scores#index'
      get '/urban_area/salaries', to: 'urban_area_salaries#index'
      get '/urban_area/images', to: 'urban_area_images#index'
      get '/urban_area/details', to: 'urban_area_details#index'
    end
  end
end
