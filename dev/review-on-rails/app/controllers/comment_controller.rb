class CommentController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        if (comment_is_valid?(comment_params[:comment]))
            if @comment.save
                redirect_to "/post/#{comment_params[:post_id]}"
            else
                flash[:error] = "Unable to submit comment"
                redirect_to "/post/#{comment_params[:post_id]}"
            end
        else
            flash[:error] = error_message(comment_params[:comment])
            redirect_to "/post/#{comment_params[:post_id]}"
        end
    end

    def load_more_comments
        @comments = Comment.joins(:user).select("users.username as username,comments.*").where("comments.id < ? AND comments.post_id = ?", params[:comment_id], params[:post_id]).order("comments.id DESC").limit(5)
        respond_to do |format|
            format.html { render partial: 'post/comments', :locals => {:comments => @comments} }
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:post_id, :comment).merge(:user_id => session[:user_id])
        end

        def error_message(comment)
            if comment == nil
                return "Comment must not be left blank"
            else
                length = comment.length
                if length > 1000
                    return "Comment must not exceed 1000 characters"
                else
                    return "Comment must not be left blank"
                end
            end
        end

        def comment_is_valid?(comment)
            comment = comment.gsub(/\s+/, "")
            if comment == nil
                return false
            else
                length = comment.length
                return length > 0 && length <= 1000
            end
        end
end
