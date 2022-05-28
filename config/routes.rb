Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }
  namespace :admin do
    get '/', to: 'users#index'
    resources :users
    resources :pending_traders
    resources :transactions
  end

  resources :stocks
  resources :quotes, except: [:show]
  get 'quotes/:symbol', to: 'quotes#show'
  resources :sell_stocks
  # get 'sell_stocks/:symbol', to: 'sell_stocks#show', as: 'get_sellstock'
  # post 'sell_stocks/:symbol', to: 'sell_stocks#create', as: 'sell_stock'
  get 'portfolio', to: 'stocks#index'
  # post 'buy/:params', to: 'stocks#create'

  resources :transactions, only: [:index]
end
