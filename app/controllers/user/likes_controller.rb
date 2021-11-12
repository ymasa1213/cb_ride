class User::LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @likes = current_user.likes.find_by(post_id: @post.id)
    @likes.destroy
    redirect_back(fallback_location: root_path)
  end
end
