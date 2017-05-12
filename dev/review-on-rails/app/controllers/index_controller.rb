class IndexController < ApplicationController
    skip_before_action :require_login
    
    def index
        @posts = Post.joins(:user).select("users.username as username, posts.*").order(id: :desc)
    end

end
