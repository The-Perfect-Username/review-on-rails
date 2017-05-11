Rails.application.routes.draw do

    get 'account', to: "account#index"
    post 'account/comments/loadmore', to: "account#loadMoreComments"
    post 'account/reviews', to: "account#reviews"
    post 'account/comments', to: "account#comments"

    get 'post', to: "post#index"
    get 'post/:id', to: "post#post"
    post 'post/create', to: "post#create"
    post 'post/destroy', to: "post#destory"

    post 'comment/create', to: "comment#create"
    post '/comments/loadmore', to: "comment#loadMoreComments"

    resources :users
    get 'register', to: "register#index"
    post 'register/run', to: "register#run"

    get 'login', to: "login#index"
    post 'login/run', to: "login#run"

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/', to: 'index#index'

end
