class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:create, :new]

  def new
    render :new
  end

  def create
    # login_user!
    @user = User.find_by_credentials(session_params[:username],
                                     session_params[:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = ["Invalid Credentials"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
