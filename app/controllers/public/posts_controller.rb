class Public::PostsController < ApplicationController
  before_action :correct_user, only: [:destroy, :edit, :update]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_path(id: current_user.id)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice] = "You have updated book successfully."
       redirect_to post_path(@post.id)
    else
      render :edit
    end
  end


  def index
    @posts = Post.includes(:user).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  # 投稿データのストロングパラメータ
  
  private
  
  def correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path, notice: "他のユーザーの投稿は編集できません"
    end
  end

  def post_params
    params.require(:post).permit(:image, :title, :body)
  end
end
