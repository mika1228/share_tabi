class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.page(params[:page]).per(12).order(created_at: :desc)
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end
end
