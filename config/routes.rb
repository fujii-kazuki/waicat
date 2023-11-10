Rails.application.routes.draw do

  root 'public/homes#top'
  
  ################## 利用者側 ##################
  # deviseコントローラー
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    # Aboutページ
    get 'about' => 'homes#about', as: 'about'
    # ゲストログイン
    devise_scope :user do
      post 'guest_sign_in' => 'sessions#guest_sign_in', as: 'guest_session'
    end
    
    # public/searchesコントローラー
    scope :cats do
      resources :searches, only: [:index]
    end
    
    # public/catsコントローラー
    resources :cats do
      post 'confirm', on: :collection

      # public/commentsコントローラー
      resources :comments, only: [:index, :create, :destroy]

      # public/candicatesコントローラー
      resources :candidates, only: [:create] do
        get 'confirm', on: :collection
        patch 'decide'
        patch 'decline'
      end
    end

    # public/bookmarksコントローラー
    scope :users do
      resources :bookmarks, only: [:index, :create, :destroy]
    end

    # public/usersコントローラー
    namespace :users do
      get 'my_page', action: 'show'
      get 'confirm'
      scope :infomation do
        get 'edit', as: 'infomation_edit'
        patch 'update', as: 'infomation_update'
      end
    end

    # public/chatroomsコントローラー
    resources :chatrooms, only: [:index, :show] do

      # public/messagesコントローラー
      resources :messages, only: [:create]
    end

    # public/noticesコントローラー
    resources :notices, only: [:index] do
      patch 'leave'
    end
  end


  ################## 管理者側 ##################
  # deviseコントローラー
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '/' => 'homes#top', as: 'top'

    # admin/catsコントローラー
    resources :cats, only: [:index, :show] do
      patch 'leave'

      # admin/commentsコントローラー
      resources :comments, only: [:index, :show] do
        patch 'leave'
      end
    end

    # admin/chatroomsコントローラー
    resources :chatrooms, only: [:index, :show, :destroy] do

      # admin/messagesコントローラー
      patch 'messages/:message_id/leave' => 'messages#leave'
    end

    # admin/breedsコントローラー
    resources :breeds, only: [:index, :create, :destroy]

    # admin/animal_printsコントローラー
    resources :animal_prints, only: [:index, :create, :destroy]

    # admin/noticesコントローラー
    resources :notices, only: [:index, :create] do
      patch 'leave'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
