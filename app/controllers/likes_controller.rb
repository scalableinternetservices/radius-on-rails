class LikesController < ApplicationController
  before_action :authenticate_user!, :find_post
  before_action :find_like, only: [:destroy]

  def create
    unless already_liked?
      @post.likes.create(user_id: current_user.id)
    end
    redirect_to feed_path
  end

  def destroy
    if already_liked?
      @like.destroy
    end
    redirect_to feed_path
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_like
      @like = @post.likes.find(params[:id])
    end

    def already_liked?
      Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end
end
