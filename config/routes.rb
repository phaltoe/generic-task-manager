Rails.application.routes.draw do
  resources :tasks
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions", omniauth_callbacks: "omniauth_callbacks"}, :path => 'accounts'

  resources :projects do
    resources :tasks
    post 'tasks/:id/toggle_complete', to: 'tasks#toggle_complete', as: 'toggle_task_complete'
  end
  get 'projects/:id/edit_permissions', to: 'projects#edit_permissions', as: 'edit_project_permissions'
  get 'projects/:id/add_team_members', to: 'projects#add_team_members', as: 'add_project_team_members'
  get 'projects/:id/view_team_members', to: 'projects#view_team_members', as: 'view_project_team_members'

  root to: 'static#index'
end
