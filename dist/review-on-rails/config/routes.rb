Rails.application.routes.draw do
    resources :users
    get 'register', to: "register#index"
    post 'register/run', to: "register#run"

    get 'login', to: "login#index"
    post 'login/run', to: "login#run"

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/', to: 'index#index'

end
