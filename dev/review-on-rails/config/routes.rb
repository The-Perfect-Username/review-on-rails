Rails.application.routes.draw do


    get 'account', to: "user#account"
    get 'user/:id', to: "user#index"
    get 'logout', to: "user#logout"

    post 'account/comments/loadmore', to: "user#load_more_comments"
    post 'account/reviews', to: "user#reviews"
    post 'account/comments', to: "user#comments"

    get 'post', to: "post#index"
    get 'post/:id', to: "post#post"
    post 'post/create', to: "post#create"
    post 'post/destroy', to: "post#destory"
    post 'reviews/loadmore', to: "post#load_more_posts"
    post 'account/reviews/loadmore', to: "post#load_more_posts_by_user"

    post 'comment/create', to: "comment#create"
    post '/comments/loadmore', to: "comment#load_more_comments"

    resources :users
    get 'register', to: "register#index"
    post 'register/run', to: "register#run"

    get 'login', to: "login#index"
    post 'login/run', to: "login#run"

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    get '/', to: 'index#index'

end
