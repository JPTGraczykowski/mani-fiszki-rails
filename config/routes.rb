Rails.application.routes.draw do
  resource :session
  get "up" => "rails/health#show", as: :rails_health_check
  put "toggle_language" => "preferred_languages#toggle_language"

  root "dashboard#show"

  resources :flashcard_sets, only: [:index, :show] do
    resources :flashcards, only: [:index] do
      get "hide_flashcards", on: :collection
    end
  end

  resources :sentence_sets, only: [:index, :show]

  namespace :admin do
    resources :flashcard_sets do
      resources :flashcards, except: [:show] do
        patch "reorder", on: :member
      end
    end
  end
end
