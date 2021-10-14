Rails.application.routes.draw do
  get 'my_phrases/index'
  devise_for :admins
  devise_for :users
  
  root to: 'homes#top'
  
  get 'users/confirm' => 'users#confirm', as: 'confirm'
  get 'users/leave' => 'users#leave', as: 'leave'
  resources :users, only: [:show, :edit, :update] do
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'followings' => 'relationships#followings', as: 'followings'
    resource :relationships, only: [:create, :destroy]
  end

  get 'groups/match' => 'groups#match', as: 'match'
  get 'groups/password' => 'groups#password', as: 'password'
  resources :groups do
    resources :phrases, except: [:new] do
      resources :favorites, only: [:create, :destroy]
      resources :bookmarks, only: [:create, :destroy]
      resources :knowledges, except: [:index] do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
  
  get 'my_phrases' => 'my_phrases#index', as: 'my_phrases'
  resources :group_users, only: [:create, :destroy] 
  
  get 'searches/search' => 'groups#search', as: 'search'
  
  
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :update]
    resources :group, only: [:show, :destroy] do
      resources :phrases, only: [:index, :show] do
        resources :knowledges, only: [:show, :destroy] do
          resources :comments, only: [:destroy] 
        end
      end
    end 
  
    get '/search' => 'searches#search', as: 'admin_search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
