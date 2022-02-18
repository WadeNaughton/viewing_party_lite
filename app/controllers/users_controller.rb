class UsersController < ApplicationController
  # before_action :current_user

  def index
  end

  def show
    @user = User.find(session[:user_id])
    @parties = @user.parties
  end

  def new
  end

  def discover
    @user = User.find(session[:user_id])
  end

  def login_form
  end

  def login
      user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       flash[:success] = "Welcome, #{user.email}!"
       redirect_to dashboard_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
end
