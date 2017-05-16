class UserController < ApplicationController
    skip_before_action :require_login, :only => [:index, :load_more_comments, :reviews, :comments]

    def index
        @user = User.find(params[:id])
        @comments = Comment.joins(:user).
                            select("users.username as username,comments.*").
                            where("comments.user_id = ?", @user.id).
                            order("comments.id DESC").
                            limit(5)
    end

    def account
        @account = User.find(session[:user_id])
        @comments = Comment.joins(:user).
                            select("users.username as username,comments.*").
                            where("comments.user_id = ?", @account.id).
                            order("comments.id DESC").limit(5)
    end

    def load_more_comments
        unless params[:id]
            @comments = Comment.joins(:user).
                                select("users.username as username,comments.*").
                                where("comments.id < ?", params[:comment_id]).
                                order("comments.id DESC").
                                limit(5)
        else
            @comments = Comment.joins(:user).
                                select("users.username as username,comments.*").
                                where("comments.id < ? AND comments.user_id = ?", params[:comment_id], params[:id]).
                                order("comments.id DESC").
                                limit(5)
        end

        respond_to do |format|
            format.html { render partial: 'comment/comments', :locals => {:comments => @comments} }
        end
    end

    def reviews
        user_id = params[:user_id] ? params[:user_id] : session[:user_id]
        @posts = Post.joins(:user).
                      select("users.username as username, posts.*").
                      where("users.id = ?", user_id).
                      order(id: :desc).
                      limit(5)

          if @posts.empty?
              partial = render :partial => 'post/noreviews'
          else
              psrtial = render :partial => 'post/reviews', :locals => {:posts => @posts}
          end

        respond_to do |format|
            format.html { partial }
        end
    end

    def comments
        user_id = params[:user_id] ? params[:user_id] : session[:user_id]
        @comments = Comment.joins(:user).
                            select("users.username as username,comments.*").
                            where("comments.user_id = ?", user_id).
                            order("comments.id DESC").limit(5)

        if @comments.empty?
            partial = render partial: 'comment/noComments'
        else
            partial = render partial: 'comment/comments', :locals => {:comments => @comments}
        end

        respond_to do |format|
            format.html { partial }
        end
    end

    def logout
        reset_session
        redirect_to "/login"
    end
end
