class UsersController < ApplicationController
  before_action :require_user_logged_in,only: [:index, :show, :followings, :followers, :likes]
  
  def index
    @users = User.all.order(id: :desc).page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "SUCCESS!!"
      redirect_to login_url
    else
      flash.now[:danger] = "FAILED"
      render :new
    end
  end
    
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "UPDATED !!"
      redirect_to @user
    else
      flash.now[:danger] = "FAILED"
      render :edit
    end
    
  end
    
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    flash[:success] = "NO ACCOUNT"
    redirect_to root_path
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @posts = @user.likes.order(id: :desc).page(params[:page])
    counts(@user)
  end 
    
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :image_profile)
  end
    
end
