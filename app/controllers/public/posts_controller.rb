class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end
  
  def index
      @posts = params[:category_id].present? ? Category.find(params[:category_id]).posts : Post.all.order(created_at: :desc) 
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  private

  def post_params
    params.require(:post).permit(:category_id, :user_id, :spot_name, :post_image, :date, :prefecture, :address, :post_comment, :is_active)
  end
  
end
