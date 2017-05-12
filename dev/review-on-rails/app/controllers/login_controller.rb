class LoginController < ApplicationController

    skip_before_action :require_login

    def index
      @login = User.new
    end

    def run
      user = User.find_by(username: session_params[:username])
      if user && user.authenticate(session_params[:password])
          session[:user_id] = user.id
          redirect_to :controller => 'index', :action => 'index'
      else
          flash[:message] = "Username and password combination is incorrect"
          redirect_to :controller => 'login', :action => 'index'
      end
    end

    private
        def session_params
            params.require(:user).permit(:username, :password)
        end
end
