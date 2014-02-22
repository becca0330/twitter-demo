class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :follow, :unfollow ]
  def show
    @user = User.find(params[:id])
  end
  
  def follow
    if current_user == @user
      flash[:error] = "You cannot follow yourself"
    elsif current_user.following?(@user)
      flash[:error] = "You already follow #{@user.email}"
    else
      unless current_user.follow(@user).nil?
        flash[:success] ="You are following #{@user.email}"
      else
        flash[:error] + "Something went wrong. You cannot follow #{@user.email}"
      end
    end
    redirect_to @user
  end
  
  def unfollow 
    if current_user.unfollow(@user)
      flash[:success] = "You no longer follow #{@user.email}"
    else
      flash[:error] = "You cannot unfollow #{@user.email}"
    end
    redirect_to @user
  end
    
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
