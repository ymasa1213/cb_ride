class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only:[:edit, :update]
  #他のユーザーのpostを変更できないようにする

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "新規投稿しました"
    redirect_to posts_path
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all.order(id: 'DESC').page(params[:page]).per(6)
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

# 検索
  def search
    @posts = Post.search(params[:keyword]).page(params[:page]).per(6)
    @keyword = params[:keyword]
    render 'index'
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
     unless @post.user == current_user
     redirect_to posts_path
     end
  end
end