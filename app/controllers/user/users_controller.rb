class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  #他のユーザーを編集できないように

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
      flash[:alert] = "必要事項を入力してください"
      render "edit"
    end
  end

  def index
    @users = User.where.not(id: current_user.id).page(params[:page]).per(8)
    @posts = Post.all
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
    @user = User.find(params[:id])
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
    @user = User.find(params[:id])
  end

  def withdraw
    @user = current_user
    @user.destroy
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
