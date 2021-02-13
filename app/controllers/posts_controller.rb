class PostsController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  
  def index
      # @posts = Post.all
      if params[:keyword].blank?
        @posts = Post.all
      else
        @posts = Post.where('word like ? or description like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      flash[:success] = '追加されました'
      redirec_to @post
    else
      flash.now[:danger] = '追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    
    if @post.save
      flash[:success] = '正常に更新されました'
      redirec_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :new
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
  def message_params
    params.require(:post).permit(:word, :description)
  end
end
