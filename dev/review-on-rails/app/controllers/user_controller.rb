class UserController < ApplicationController

    def index
        @user = User.find(params[:id])
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.user_id = ?", @user.id).order("comments.id DESC").limit(5)
    end

    def account
        @account = User.find(session[:user_id])
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.user_id = ?", @account.id).order("comments.id DESC").limit(5)
    end

    def loadMoreComments
        unless params[:id]
            @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.id < ?", params[:comment_id]).order("comments.id DESC").limit(5)
        else
            @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.id < ? AND comments.user_id = ?", params[:comment_id], params[:id]).order("comments.id DESC").limit(5)
        end

        respond_to do |format|
            format.html { render partial: 'post/comments', :locals => {:comments => @comments} }
        end
    end

    def reviews
        unless params[:id]
            @posts = Post.joins(:user).select("users.username as username, posts.*").where("users.id = ?", session[:user_id]).order(id: :desc)
        else
            @posts = Post.joins(:user).select("users.username as username, posts.*").where("users.id = ?", params[:id]).order(id: :desc)
        end
        respond_to do |format|
            format.html { render :partial => 'index/reviews', :locals => {:posts => @posts} }
        end
    end

    def comments
        unless params[:id]
            @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.user_id = ?", session[:user_id]).order("comments.id DESC").limit(5)
        else
            @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.id < ? AND comments.user_id = ?", params[:comment_id], params[:id]).order("comments.id DESC").limit(5)
        end
        respond_to do |format|
            format.html { render partial: 'post/comments', :locals => {:comments => @comments} }
        end
    end

    def logout
        reset_session
        redirect_to "/login"
    end
end
