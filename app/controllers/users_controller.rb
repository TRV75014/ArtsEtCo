class UsersController < ApplicationController
  attr_accessor :remember_token

  def new
    @user = User.new  # Generates a new User instance and pass it to the view in '/views/users/new.html.erb'
  end

  def create
    @user = User.new(user_params) #Generate a new User instance using parameters collected from the form
    if @user.valid?
      @user.is_admin = false
      @user.save
      log_in @user
      remember @user
      redirect_to '/home'
    else
      flash[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
    @user = User.find_by id: session[:user_id]
  end

  def update
    @user = User.find_by id: session[:user_id]
    if @user.update(email: user_params[:email])
      redirect_to "/home"
    elsif @user.update(password: user_params[:password])
      redirect_to "/home"
    else
      render "/account"
    end
  end  # Returns a random token.

  def index
    @current_user ||= User.find_by(id: session[:user_id])
    if current_user.is_admin?
      @users = User.all
    else
      redirect_to '/home'
    end
  end

  def admin_update
    @user = User.find_by(id: params[:id])
    if @user.is_admin?
      User.where('id = ?', @user_id).update_all(:is_admin => false)
    else
      User.where('id = ?', @user_id).update_all(:is_admin => true)
    end
    redirect_to '/users'
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def delete
  end

  private
  # Method to safely collect data from the user's parameters form and store them in the database
  def user_params
    params.require(:user).permit(:username, :email, :password, :id)
  end
end
