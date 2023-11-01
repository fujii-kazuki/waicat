Rails.application.routes.draw do

  root 'public/homes#top'

  ################## 利用者側 ##################  
  scope module: :public do
    get 'about' => 'homes#about', as: 'about'
    
    # public/searchesコントローラー
    scope :cats do
      resources :searches, only: [:index]
    end
    
    # public/catsコントローラー
    resources :cats do
      member do
        get 'thanks'
      end

      # public/commentsコントローラー
      resources :comments, only: [:index, :create]

      # public/candicatesコントローラー
      resources :candicates, only: [:create] do
        patch 'confirm'
        patch 'decline'
      end
    end

    # public/bookmarksコントローラー
    scope :users do
      resources :bookmarks, only: [:index, :create, :destroy]
    end

    # public/usersコントローラー
    namespace :users do
      get 'my_page', action:'show'
      get 'check'
      patch 'leave'
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
  namespace :admin do
    get 'homes/top' => 'homes#top', as: 'root'

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
