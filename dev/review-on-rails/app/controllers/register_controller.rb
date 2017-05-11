class RegisterController < ApplicationController

  skip_before_action :require_login

  def index
      @registration = User.new
  end

  def run
      @registration = User.new(registration_params)
      if @registration.save
          session[:user_id] = @registration.id
          redirect_to :controller => 'index', :action => 'index'
      else
          redirect_to :controller => 'register', :action => 'index'
      end
  end

  private
    def registration_params
        params.require(:user).permit(:name, :email, :username, :password)
    end

end
