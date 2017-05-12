class RegisterController < ApplicationController

    skip_before_action :require_login

    # Registration page
    def index
      @registration = User.new
    end

    # Creates a new user account
    def run
      @registration = User.new(registration_params)
      # Error message array
      errors = []
      # Parameter validation
      validate_name(errors, registration_params[:name])
      validate_username(errors, registration_params[:username])
      validate_email(errors, registration_params[:email])
      validate_password(errors, registration_params[:password])

      if errors.length == 0 && @registration.save
          session[:user_id] = @registration.id
          redirect_to :controller => 'index', :action => 'index'
      else
          flash[:error] = errors
          redirect_to :controller => 'register', :action => 'index'
      end
    end

    private
        # Permits the registration's form input for submission
        def registration_params
            params.require(:user).permit(:name, :email, :username, :password)
        end

        # Checks if the email address already exists in the database
        def email_exists?(email)
            user = User.find_by(email: email)
            return !user.nil?
        end

        # Validates the user's email address and passes an error message if
        # it fails validation
        def validate_email(errors, email)
            if email.nil? # Email must not be nil
                errors.push("<b>Email</b> must not be left blank")
            elsif valid_email_format?(email) != 0 # Email must have the correct format
                errors.push("<b>Email</b> must not be left blank")
            elsif email.length > 100 # Email must not exceed 100 characters
                errors.push("<b>Email</b> is too long")
            end
            # Checks if the email address already exists
            if email_exists?(email)
                errors.push("<b>Email</b> already exists")
            end

        end

        # Validates the email format
        # Returns 0 if it matches the format
        def valid_email_format?(email)
            pattern = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
            return email =~ pattern
        end

        # Validates the name format
        # Returns 0 if it matches the format
        def valid_name_format?(name)
            pattern = /\A[-a-z\s]+\Z/i
            return name =~ pattern
        end

        # Validates the user's password and passes an error message if
        # it fails validation
        def validate_password(errors, password)
            # password must have at least 6 characters
            if password.nil?
                errors.push("<b>Password</b> must have at least 6 characters")
            elsif password.length < 6
                errors.push("<b>Password</b> must have at least 6 characters")
            end
        end

        # Validates the user's name and passes an error message if
        # it fails validation
        def validate_name(errors, name)
            # Checks if input is nil
            if name.nil?
                errors.push("<b>Name</b> must not be left blank")
            elsif name.length < 2 # name must be at least 2 characters
                errors.push("<b>Name</b> must have at least 2 characters")
            elsif name.length > 100 # name must be at most 100 characters
                errors.push("<b>Name</b> is too long")
            end
            # Name must only contain letters, whitespace, and hyphens
            if valid_name_format?(name) != 0
                errors.push("<b>Name</b> must ony contain letters, whitespace, and hyphens")
            end
        end

        # Validates the user's username and passes an error message if
        # it fails validation
        def validate_username(errors, username)
            if username.nil? # username must not be nil
                errors.push("<b>Username</b> must not be left blank")
            elsif username.length < 2 # username must have at least 2 characters
                errors.push("<b>Username</b> must have at least 2 characters")
            elsif username.length > 25 # username must hat at most 100 characters
                errors.push("<b>Username</b> must not exceed 25 characters")
            end
        end

end
