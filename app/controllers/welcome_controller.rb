class WelcomeController < ApplicationController
  def index
    @users = User.all
  end

  def register

  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Error: Name can't be blank, Email can't be blank and must be valid, Password and Password Confirmation must match."
      redirect_to "/register"
    end
  end

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
