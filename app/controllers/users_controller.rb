class UsersController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #login method goes here to auto log in user after
      #creating account
      login_user!(@user)
      redirect_to new_user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
