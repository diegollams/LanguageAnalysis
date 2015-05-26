class PostsController < ApplicationController

  before_action :set_post,only: [:destroy,:update]
  def index
    @posts = JSON.parse Post.all.to_json include: :words
  end

  def create
    @post = Post.new post_params
    if @post.save
      render json: @post.as_json(include: :words)
    else
      render json: @post.errors , status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  def update
    if @post.update post_params
      render json: @post.as_json(include: :words)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
  def set_post
    @post = Post.find params[:id]
  end
  def post_params
    params.require(:post).permit(:body,:title)
  end
end
