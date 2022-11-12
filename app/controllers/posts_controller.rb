class PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
    authorize @post
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def post_params
    params.require(:post).permit(:content, :photo)
  end
end
