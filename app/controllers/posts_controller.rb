class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :destroy, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
  def index
      # @posts = Post.all
      if params[:keyword].blank?
        @posts = current_user.posts.page(params[:page]).per(10)
      else
        @posts = current_user.posts.where('word like ? or description like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%").page(params[:page]).per(10)
      end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      flash[:success] = '追加されました'
      redirect_to @post
    else
      flash.now[:danger] = '追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = '正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    @post.destroy
    
    flash[:success] = '正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end

  # Strong Parameter
  def post_params
    params.require(:post).permit(:word, :description)
  end
  
  def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      unless @post
      redirect_to root_url
      end
  end 
end
