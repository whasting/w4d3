class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login_user!(user)
    session[:session_token] = @user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  private
  def application_params
    params.require(:user).permit(:username, :password)
  end

  def require_no_user!
    redirect_to cats_url if current_user
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token:
                                session[:session_token])
  end
end
