class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end 
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "SUCCESS"
      redirect_to @post
    else
      flash.now[:danger] = "FAILED"
      render :edit
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "POSTED !!"
      redirect_to root_url
    else 
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = "FAILED"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "DELETE"
    redirect_to root_url
  end
    
  
  private
  
  def post_params
    params.require(:post).permit(:content, :image,:image_profile)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end 
  end
end



