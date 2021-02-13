class PostsController < ApplicationController
  def index
      # @posts = Post.all
      if params[:keyword].blank?
        @posts = Post.all
      else
        @posts = Post.where('word like ? or description like ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      end
  end

  def show
      @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.save
      flash[:success] = '正常に更新されました'
      redirec_to @post
    else
      flash.now[:danger] = '更新されませんでした'
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    flash[:success] = '正常に削除されました'
    redirect_to root_url
  end
  
  private

  # Strong Parameter
  def message_params
    params.require(:post).permit(:word, :description)
  end
end
