Rails.application.routes.draw do
  devise_for :users
  resources :pins do
  	get 'tags/:tag', to: 'pins#index', as: :tag
    member do
      put "fleur", to: "pins#upvote"
    end
  end
  root "pins#index"
  
end
