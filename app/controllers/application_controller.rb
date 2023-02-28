class ApplicationController < ActionController::Base
    include ApplicationHelper
    include SessionsHelper
    
    def logged_in_user
        unless logged_in? 
          store_location
          flash[:red] = "Please log in"
          redirect_to login_url
        end
    end
end
