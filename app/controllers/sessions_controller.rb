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

      number_of_directReports = result[3].count
      session[:name]=nil
      session[:name]=[]
      n = 0
      result[3].each do |r|
        name = result[3][n].try(:split, ',').first || []
        name.slice!(0..2)
        session[:name] << name
        n+=1
      end

      session[:directReports] = result[3]
      session[:directReports_no] = number_of_directReports
      session[:group] = result[4]
      redirect_to login_path,
        # alert: "#{result[0]}, #{result[1]}, #{result[2]}"

        alert: "#{session[:sAMAccountName]}, #{session[:name]}, #{session[:directReports_no]}"

        # alert: "#{result}"
    else
      redirect_to login_path, alert: "Invalid username/password combination"
    end
  end

  def destroy
  end
end
