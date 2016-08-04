Rails.application.routes.draw do
  devise_for :users
  get 'tags/:tag', to: 'pins#index', as: :tag
  resources :pins do
    member do
      put "fleur", to: "pins#upvote"
      patch 'participate'
      patch 'stop_participating'
    end
  end
  root "pins#index"
end
