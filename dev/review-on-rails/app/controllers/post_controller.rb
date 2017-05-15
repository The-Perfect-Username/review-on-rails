class PostController < ApplicationController

    skip_before_action :require_login, :only => [:post, :load_more_posts, :load_more_posts_by_user]

  def index
      @post = Post.new
  end

  def post
      @post = Post.joins(:user).
                   select("users.username as username, posts.*").
                   where(id: params[:id]).
                   first
      @comment = Comment.new
      @comments = Comment.joins(:user).
                          select("users.username as username,comments.*").
                          where(post_id: params[:id]).
                          order("comments.id DESC").
                          limit(5)

      @numberOfComments = Comment.where(post_id: params[:id]).length
  end

  # Load the next 5 reviews on the main page
  def load_more_posts
      @posts = Post.joins(:user).
                    select("users.username as username, posts.*").
                    where("posts.id < ?", params[:post_id]).
                    order("posts.id DESC").
                    limit(5)

      respond_to do |format|
          format.html { render partial: 'post/reviews', :locals => {:posts => @posts} }
      end
  end

  # Load more posts by user id
  def load_more_posts_by_user
      # Either the user ID of another user's account or the user's own ID
      user_id = params[:user_id] ? params[:user_id] : session[:user_id]
      # Get the next 5 reviews
      @posts = Post.joins(:user).
                    select("users.username as username, posts.*").
                    where("posts.id < ? AND posts.user_id = ?", params[:post_id], user_id).
                    order("posts.id DESC").
                    limit(5)
      # Return rendered html
      respond_to do |format|
          format.html { render partial: 'post/reviews', :locals => {:posts => @posts} }
      end
  end

  # Create a new review
  def create
      # Error message array
      @@errors = []
      # Validate parameters
      validate_params
      # If no error were found then submit the review
      if (@@errors.empty?)
          @post = Post.new(post_params)
          if @post.save # Save review then redirect to index if successful
              redirect_to :controller => "index", :action => "index"
          else # Display error if the review was unable to submit
              flash[:error] = "Unable to submit post"
              redirect_to :controller => "post", :action => "index"
          end
      else # Display errors and redirect back to the form
          flash[:error] = @@errors
          redirect_to :controller => "post", :action => "index"
      end
  end

  private
    def post_params
        params.require(:post).permit(:title, :post, :rating).merge(:user_id => session[:user_id])
    end

    # Valudate all parameters
    def validate_params
        validate_title(post_params[:title])
        validate_review(post_params[:title])
        validate_rating(post_params[:rating])
    end

    # Validate title
    # Title should contain 1-100 characters
    def validate_title(str)

        if str == nil
            @@errors.push("<b>Title</b> must not be left blank")
            return false
        end

        len = str.length
        unless len <= 100 && len > 0
            @@errors.push("<b>Title</b> must contain 1 to 100 characters")
        end
    end

    # Validate review post
    # Review should contain 1-1000 characters
    def validate_review(str)

        if str == nil
            @@errors.push("<b>Review</b> must not be left blank")
            return false
        end

        len = str.length
        unless len <= 1000 && len > 0
            @@errors.push("<b>Review</b> must have 1 to 1000 characters")
        end
    end

    # Validate rating
    # Checks to see if the rate provided is in range of 1 to 5
    # Used in case user changes value on front end
    def validate_rating(rate)
        unless rate.to_i.between?(0,6)
            @@errors.push("<b>Review</b> must have 1 to 1000 characters")
        end
    end
end
