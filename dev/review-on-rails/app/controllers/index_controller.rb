class IndexController < ApplicationController
    skip_before_action :require_login

    def index
        # Get the 5 most recent reviews made from all users
        @posts = Post.joins(:user).select("users.username as username, posts.*").order(id: :desc).limit(5)
    end

end
