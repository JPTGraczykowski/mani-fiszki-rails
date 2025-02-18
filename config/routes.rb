Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  put "toggle_language" => "preferred_languages#toggle_language"

  root "flashcard_sets#index"

  resources :flashcard_sets, only: [:index, :show]
end
