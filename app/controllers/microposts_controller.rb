class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: [:destroy]
    def create
         @micropost = current_user.microposts.build(micropost_params)
         @micropost.image.attach(params[:micropost][:image])

         if @micropost.save
            flash[:green] = "Blip created sucessfully"
            redirect_to root_url
         else
            render 'static_pages/home'
         end
    end

    def destroy
        @micropost.destroy
        flash[:green] = "Micropost deleted successfully"
        redirect_to request.referrer || root_url
    end
    def like
        @micropost = Micropost.find(params[:id])
          if current_user.voted_up_on? @micropost
            @micropost.downvote_by current_user
          else #not voted
            @micropost.upvote_by current_user
          end
          respond_to do |format|
           format.js
          end 
    end
    

    private 
    def micropost_params
        params.require(:micropost).permit(:content, :image)
    end

    def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
    end
    
end
