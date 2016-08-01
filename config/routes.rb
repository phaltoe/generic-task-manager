Rails.application.routes.draw do
  resources :tasks
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions", omniauth_callbacks: "omniauth_callbacks"}, :path => 'accounts'

  resources :projects do
    resources :team_members
    resources :tasks
    post 'tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_task_complete'
  end

  root to: 'static#index'
end
