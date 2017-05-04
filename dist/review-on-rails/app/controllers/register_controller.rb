class RegisterController < ApplicationController
  def index
      @registration = User.new
  end

  def run
      @registration = User.new(registration_params)
      if @registration.save
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
