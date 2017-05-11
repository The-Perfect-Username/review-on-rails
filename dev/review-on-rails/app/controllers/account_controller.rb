class AccountController < ApplicationController

    def index
        @account = User.find(session[:user_id])
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.user_id = ?", @account.id).order("comments.id DESC").limit(5)
        puts @comments.inspect
    end

    def loadMoreComments
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.id < ?", params[:comment_id]).order("comments.id DESC").limit(5)
        respond_to do |format|
            format.html { render partial: 'post/comments', :locals => {:comments => @comments} }
        end
    end

    def reviews
        @posts = Post.joins(:user).select("users.username as username, posts.*").order(id: :desc)
        respond_to do |format|
            format.html { render :partial => 'index/reviews', :locals => {:posts => @posts} }
        end
    end

    def comments
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.user_id = ?", session[:user_id]).order("comments.id DESC").limit(5)
        respond_to do |format|
            format.html { render partial: 'post/comments', :locals => {:comments => @comments} }
        end
    end

end
