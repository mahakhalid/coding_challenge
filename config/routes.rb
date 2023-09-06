# frozen_string_literal: true
Rails.application.routes.draw do
  resources :talents
  resources :learning_paths

  resources :courses do
    member do
      post 'mark_completed/:talent_id', to: 'courses#mark_completed', as: :mark_completed
      post 'complete_and_assign_next/:talent_id', to: 'courses#complete_and_assign_next', as: :complete_and_assign_next
    end
  end

  resources :learning_paths, only: [] do
    resources :courses, only: [:create], controller: 'learning_paths/courses'
  end

  resources :authors, except: [:destroy] do
    member do
      delete 'destroy_with_transfer', action: 'destroy_with_transfer'
    end
  end
end