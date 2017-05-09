Rails.application.routes.draw do

    get 'post', to: "post#index"
    get 'post/:id', to: "post#post"
    post 'post/create', to: "post#create"
    post 'post/destroy', to: "post#destory"

    resources :users
    get 'register', to: "register#index"
    post 'register/run', to: "register#run"

    get 'login', to: "login#index"
    post 'login/run', to: "login#run"

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/', to: 'index#index'

end
