Rails.application.routes.draw do

  root 'static_pages#index'

  get "subreddits/:id/posts/:post_id/upvote", to: 'subreddits#upvote', as: 'subreddits_upvote'

  get "static_pages/posts/:post_id/upvote", to: 'static_pages#upvote', as: 'static_pages_upvote'

  devise_for :users

  resources :users, only: [] do
    collection do
      get 'settings'
      patch 'update_settings'
    end
  end

  resources :subreddits do
    collection do
      get 'trending'
      get 'newest'
    end
    member do
      get 'subscribe'
      get 'unsubscribe'
    end
    resources :posts do
      resources :comments do
      end
    end
  end

  resources :posts, only: [] do
    collection do
      get 'trending'
      get 'newest'
    end
  end

  namespace :api do
    api version: 1, module: 'v1', allow_prefix: 'v' do
      resources :subreddits, except: [:new, :edit] do
        resources :posts, except: [:new, :edit] do
          get 'upvote'
          resources :comments, only: [:index, :create, :destroy]
        end
      end
    end
  end

  mount RocketDocs::Engine => '/api-doc'

end
