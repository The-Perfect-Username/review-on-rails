class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  # Checks to see if the user is logged in
  def logged_in?
      return session[:user_id] != nil
  end

  private
    # Redirects user to the login page if they are not yet logged in
    def require_login
        unless logged_in?
            redirect_to :controller => 'login', :action => 'index'
        end
    end
end
