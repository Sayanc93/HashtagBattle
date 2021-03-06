class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to dashboard_path, notice: "Signed In!"
  end

  def destroy
    current_user.update_attributes(connected: false)
    session[:user_id] = nil
    redirect_to root_url
  end
end
