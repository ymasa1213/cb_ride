class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to root_path
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
    @posts = Post.all.order(id: 'DESC')
    @user = current_user

  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
      redirect_to post_path
    else
      render 'edit'
    end
  end

  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render 'index'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
