class UsersController < ApplicationController
  
  before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update] #[]にはURLを打っても行かせない
  
  def index
        @users = User.all
        @book = Book.new
        @user = User.find(current_user.id)
  end
    
  def show
      @user = User.find(params[:id])
      @book = Book.new
      @books = @user.books #@userにはユーザー情報、そこに紐づいているbooksモデルの本たち
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
            render "edit"
    else
        redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.id = current_user.id
    if @user.update(user_params)
            redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
            render "edit"
    end
  end
  
  def following #フォロワー一覧
        @user = User.find(params[:id])
  end

  def followed #フォロー一覧
        @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
  
  def ensure_correct_user #[]にはURLを打ったらユーザー詳細に返す
        @user = User.find(params[:id])
        unless @user == current_user
            redirect_to user_path(current_user)
        end
  end
  
end
