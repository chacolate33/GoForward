Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  root to: 'homes#top'
  get 'homes/myphrase' => 'homes#myphrase', as: 'myphrase'

  patch '/leave' => 'users#leave', as: 'leave'
  get '/confirm' => 'users#confirm', as: 'confirm'
  resources :users, only: [:show, :edit, :update] do
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'followings' => 'relationships#followings', as: 'followings'
    resource :relationships, only: [:create, :destroy]
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

  resources :groups do
    resources :applies, only: [:index, :create, :destroy]
    resources :phrases, except: [:new] do
      resource :bookmarks, only: [:create, :destroy]
      resources :knowledges, except: [:index] do
        resources :comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
    end
  end

  resources :group_users, only: [:create, :destroy]

  get 'searches/search' => 'searches#search', as: 'search'


  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :update] do
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'followings' => 'relationships#followings', as: 'followings'
    end
    resources :groups, only: [:show, :destroy] do
      resources :phrases, only: [:index, :show, :destroy] do
        resources :knowledges, only: [:show, :destroy] do
          resources :comments, only: [:destroy]
        end
      end
    end

    get '/search' => 'searches#search', as: 'search'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
