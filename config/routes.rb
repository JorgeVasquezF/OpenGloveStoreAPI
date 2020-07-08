Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
    resources :tags 
    resources :users do
    	resources :apps
    end
    resources :passwords
    resources :apps
    resources :ratings
    resources :tags 
    resource :auth, only: %i[create]
    

	get '/apps/:id/releases', to: 'apps#showReleases'
  post '/apps/:id/tags', to: 'apps#addTag'
  get '/apps/last', to: 'apps#appLast'
  post '/apps/filter', to: 'apps#filterByTag'
  post '/apps/search', to: 'apps#search'
  get '/ratings/app/:id', to: 'ratings#ratingByApp'
  get '/ratings/average/:id', to: 'ratings#ratingAverage'
  post '/tags/apps', to: 'tags#getTagsApp'
  get '/apps/user/:id', to: 'apps#appsByUser'
  post '/apps/approve/', to: 'apps#approveApp'
  get '/apps/usercheck/:userid/:appid', to: 'apps#userCheck'
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
  get '/:token/confirm_email', to: "users#confirm_email"
  
    end
  end	
end