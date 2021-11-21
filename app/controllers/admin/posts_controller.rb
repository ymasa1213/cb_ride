class Admin::PostsController < ApplicationController
before_action :authenticate_admin!
  def index
    @posts = Post.all.order(id: 'DESC').page(params[:page]).per(6)
    @users = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

 private
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end