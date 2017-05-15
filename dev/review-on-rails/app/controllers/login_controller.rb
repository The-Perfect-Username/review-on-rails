class LoginController < ApplicationController

    skip_before_action :require_login

    def index
      @login = User.new
    end

    # Authenticate user
    def run
      # Find user by their provided username
      user = User.find_by(username: login_params[:username])
      # Check if username and password combination is correct
      if user && user.authenticate(login_params[:password])
          # Set session and redirect to index if authenticated
          session[:user_id] = user.id
          redirect_to :controller => 'index', :action => 'index'
      else # Display error message if authentication failed
          flash[:message] = "Username and password combination is incorrect"
          redirect_to :controller => 'login', :action => 'index'
      end
    end

    private
        def login_params
            params.require(:user).permit(:username, :password)
        end
end
