class User::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: 'DESC')
    # 新着順(降順)で表示
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to user_path(@user)
    else
      flash[:notice] = "必要事項を入力してください"
      render "edit"
    end
  end

  def index
    @users = User.where.not(id: current_user.id)
    @posts = Post.all
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :profile_image)
  end
end
