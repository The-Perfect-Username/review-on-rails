class PostController < ApplicationController
  def index
      @post = Post.new
  end

  def post
      @post = Post.joins(:user).select("users.username as username, posts.*").where(id: params[:id]).first
      @comment = Comment.new
      @comments = Comment.joins(:user).select("users.username as username,comments.*").where(post_id: params[:id]).order("comments.id DESC").limit(5)
      @numberOfComments = Comment.where(post_id: params[:id]).length
  end

  def create
      if (validate_params)
          @post = Post.new(post_params)
          if @post.save
              redirect_to :controller => "index", :action => "index"
          else
              flash[:error] = "Unable to submit post"
              redirect_to :controller => "post", :action => "index"
          end
      else
          flash[:error] = "Submission parameters are not valid"
          redirect_to :controller => "post", :action => "index"
      end
  end

  def destroy

  end

  private
    def post_params
        params.require(:post).permit(:title, :post, :rating).merge(:user_id => session[:user_id])
    end

    def validate_params
        return title_valid?(post_params[:title]) && post_valid?(post_params[:title]) && rating_valid?(post_params[:rating])
    end

    def title_valid?(str)
        if str == nil
            return false
        end

        len = str.length
        return len <= 100 && len > 0
    end

    def post_valid?(str)
        if str == nil
            return false
        end

        len = str.length
        return len <= 1000 && len > 0
    end

    def rating_valid?(rate)
        return rate.to_i.between?(0,6)
    end
end
