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
  resources :quotes, except: [:show]
  get 'quotes/:symbol', to: 'quotes#show'
  get 'sell_stocks/:symbol', to: 'sell_stocks#show', as: 'get_sellstock'
  post 'sell_stocks/:symbol', to: 'sell_stocks#create', as: 'sell_stock'
  get 'portfolio', to: 'stocks#index'
  resources :stocks

  resources :transactions, only: [:index]
end
