class IndexController < ApplicationController

    def index
        @posts = Post.joins(:user).select("users.username as username, posts.*").order(id: :desc)
    end

end
