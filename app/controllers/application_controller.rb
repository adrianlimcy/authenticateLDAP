class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_path, notice: "Please log in"
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(session[:auth_token]) if session[:auth_token]
  end
end
