class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    # user = User.find_by(email: params[:email])
    result = User.authenticate_ldap(params[:username], params[:password])
    if result
      session[:sAMAccountName] = result[0]
      session[:division] = result[1]
      session[:email] = result[2]
      session[:group] = result[3]
      redirect_to login_path,
        # alert: "#{result[0]}, #{result[1]}, #{result[2]}"
        alert: "#{session[:sAMAccountName]}, #{session[:group]}"
        # alert: "#{result}"
    else
      redirect_to login_path, alert: "Invalid username/password combination"
    end
  end

  def destroy
  end
end
