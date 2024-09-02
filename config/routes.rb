Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  namespace :api do
    namespace :v1 do
      resources :admin do
        collection do
          get 'telecallers', to: 'admin#telecallers'
          post 'create_telecaller', to: 'admin#create_telecaller'

          get 'call_logs', to: 'admin#call_logs'
          post 'assign_call_log', to: 'admin#assign_call_log'

          get 'customers', to: 'admin#customers'
          post 'create_customer', to: 'admin#create_customer'

          get 'tasks', to: 'admin#tasks'
          post 'create_task', to: 'admin#create_task'
        end
        member do
          get 'show_telecaller', to: 'admin#show_telecaller'
          patch 'update_telecaller', to: 'admin#update_telecaller'
          delete 'destroy_telecaller', to: 'admin#destroy_telecaller'

          patch 'update_call_log', to: 'admin#update_call_log'
          delete 'destroy_call_log', to: 'admin#destroy_call_log'

          get 'customer', to: 'admin#show_customer'
          patch 'update_customer', to: 'admin#update_customer'
          delete 'destroy_customer', to: 'admin#destroy_customer'

          patch 'update_task', to: 'admin#update_task'
          delete 'destroy_task', to: 'admin#destroy_task'

          post 'assign_customers_to_task', to: 'admin#assign_customers_to_task'
          patch 'mark_task_complete', to: 'admin#mark_task_complete'
        end
      end

      resources :telecaller do
        collection do
          get 'assigned_tasks', to: 'telecaller#assigned_tasks'
        end
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
