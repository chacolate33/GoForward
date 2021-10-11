Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  
  root to: 'homes#top'
  
  get 'users/confirm' => 'users#confirm', as: 'confirm'
  get 'users/leave' => 'users#leave', as: 'leave'
  resources :users, only: [:show, :edit, :update] do
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'following' => 'relationships#followings', as: 'followings'
    resources :relationships, only: [:create, :destroy]
  end

  get 'groups/match'
  get 'groups/password'
  resources :groups do
    resources :phrases, except: [:new] do
      resources :favorites, only: [:create, :destroy]
      resources :bookmarks, only: [:index, :create, :destroy]
      resources :knowledges, except: [:index] do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
  
  resources :group_users, only: [:create, :destroy] 
  
  get 'searches/search'
  
  
  namespace :admin do
    root to: 'homes/top'
  
    resources :users, only: [:index, :show, :update]
    resources :group, only: [:show, :destroy] do
      resources :phrases, only: [:index, :show] do
        resources :knowledges, only: [:show, :destroy] do
          get 'comments/destroy'
        end
      end
    end 
  
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
