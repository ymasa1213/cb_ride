class User::HomesController < ApplicationController
  def top
    @posts = Post.all.order(id: "DESC")
    # 最新の投稿が表示されるようにIDを降順で設定
  end

  def about
  end
end
