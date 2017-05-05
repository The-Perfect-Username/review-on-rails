class LoginController < ApplicationController
  def index
      @login = User.new
  end
  def run
      user = User.find_by(username: session_params[:username])
      if user && user.authenticate(session_params[:password])
          redirect_to :controller => 'index', :action => 'index'
      else
          redirect_to :controller => 'login', :action => 'index'
      end
  end

  private
    def session_params
        params.require(:user).permit(:username, :password)
    end
end
