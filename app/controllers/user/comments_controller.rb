class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment =  Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @comment = Comment.new
  end

   private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end