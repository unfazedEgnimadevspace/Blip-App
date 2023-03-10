class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
            user.activate
            log_in user 
            flash[:green] = "Account Activated"
            redirect_to user 
        else 
                flash[:red] = "Invalid Activation link"
                redirect_to root_url
        end
    end
    
end
