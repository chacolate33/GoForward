Rails.application.routes.draw do
  get 'knowledges/new'
  get 'knowledges/create'
  get 'knowledges/edit'
  get 'knowledges/update'
  get 'knowledges/show'
  get 'knowledges/destroy'
  get 'searches/search'
  get 'groups/new'
  get 'groups/match'
  get 'groups/create'
  get 'groups/edit'
  get 'groups/update'
  get 'groups/destroy'
  get 'groups/show'
  get 'groups/index'
  get 'groups/password'
  get 'users/show'
  get 'users/confirm'
  get 'users/leave'
  get 'users/edit'
  get 'users/update'
  
  get 'bookmarks/index'
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  
  get 'phrases/show'
  get 'phrases/destroy'
  get 'phrases/edit'
  get 'phrases/update'
  get 'phrases/index'
  get 'phrases/create'
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
end
