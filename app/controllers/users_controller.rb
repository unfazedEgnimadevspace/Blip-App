class UsersController < ApplicationController
  #this filter checks if a user is logged in before he or she can access those controllers

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
    :following, :followers]
    

  # this filter checks if the user logged is the right owner of the user resource
  before_action :correct_user, only: %i[ edit update]

  #this  filter checks if the logged in user is an admin before he can access the destroy action
  before_action :check_admin, only: %i[destroy]


  # returns all the users in the database
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 15)
  end
  

# returns only one user in the database
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.paginate(page: params[:page], per_page: 7)
   redirect_to root_url and return unless @user.activated?
  end


  #creates the empty initial user object used by the create action to sign up
  def new
    @user = User.new 
  end


  # creates a new user
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:blue] = "Check your email for an account activation link"
      redirect_to root_url
    else
      render 'new'
    end
  end


  # edits a user information
  def edit
    @user = User.find(params[:id])
  end


  #updates the user information and saves to the db
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:green] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # destroys a user resource
  def destroy
    User.find(params[:id]).destroy
    flash[:red] = "User deleted successfully"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  

  private 

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

 

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
    
    def check_admin
      redirect_to(root_url) unless current_user.admin?

    end
    
end
