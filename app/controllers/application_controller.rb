class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :require_signed_in!, :current_user

  private

  def login!(user)
    session[:session_token] = user.reset_token!
  end

  def logout!
    user.reset_token!
    session[:session_token] = nil
  end

  def current_user
    user = User.find_by_session_token(session[:session_token])
    user
  end

  def require_signed_in!
    redirect_to new_session_url unless current_user
  end

end
