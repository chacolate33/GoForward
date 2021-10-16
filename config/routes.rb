Rails.application.routes.draw do
  devise_for :admins
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

  get 'groups/match' => 'groups#match', as: 'match'
  get 'groups/password' => 'groups#password', as: 'password'
  resources :groups do
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
