Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/listings', to: 'listings#index'
      get '/urban_area_scores', to: 'urban_area_scores#index'
    end
  end
end
