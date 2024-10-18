class Public::CommentsController < ApplicationController
  
  def new
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def create
    post = Post.find(params[:post_id])
    body = current_user.comments.new(comment_params)
    body.post_id = post.id
    body.save
    redirect_to post_path(post)
  end
  
  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
