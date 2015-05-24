class PostsController < ApplicationController


  def index
    @posts = Post.all
  end

  def create
    @post = Post.new post_params
    if @post.save
      render json: @post
    else
      render json: @post.errors , status: :unprocessable_entity
    end
  end


  params.require(:post).permit(:body,:title)
end
