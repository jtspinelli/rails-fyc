Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  get 'sessions/failure'
  root 'static_pages#root'

  post "/auth/:provider/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"
  post "/log_out", to: "sessions#destroy"
  post "/auth/failure", to: "sessions#failure"
  get "/auth/failure", to: "sessions#failure"

  get "/youtubefavs", to: "youtube_favs#index"
  get '/youtubefavs/new', to: "youtube_favs#new"
  post "/youtubefavs/new", to: "youtube_favs#create"
  post "/youtubefavs", to: "youtube_favs#destroy"
end
