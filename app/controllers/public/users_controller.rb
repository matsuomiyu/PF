class Public::UsersController < ApplicationController
  def mypage
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to mypage_path(id: current_user.id)
    else
      render 'edit'
    end
  end
  
  def leave
    user = current_user
    user.update(deleted_flag: true) # 論理削除
    reset_session #ログアウト
    flash[:success] = '退会が完了しました。ご利用ありがとうございました。'
    redirect_to new_user_registration_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end