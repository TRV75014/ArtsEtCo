class ParametersController < ApplicationController
  include UsersHelper
  def new
    @parameter = Parameter.new
  end

  def create
    @parameter = Parameter.new(parameters_params) #Generate a new User instance using parameters collected from the form
    @parameter.users_id = session[:user_id]
    if @parameter.save
      session[:parameter_id] = @parameter.id
    redirect_to '/home'
    else
      render 'home'
    end
  end

  def update
    @parameter = Parameter.new(parameters_params) #Generate a new User instance using parameters collected from the form
    @parameter.users_id = session[:user_id]
    if @parameter.save
      session[:parameter_id] = @parameter.id
      redirect_to '/generate'
    else
      render 'home'
    end
  end

  def home
    @nbParameters = Parameter.all.count
    @parameter = Parameter.find(@nbParameters)
    @current_user = User.find_by id: session[:user_id]
    #@is_admin = @current_user.is_admin?

    # note moyenne
    @paintings = Painting.where(users_id: session[:user_id])
    @note_moyenne = 0.0
    @paintings.each do |p|
      @note_moyenne = @note_moyenne+ p.mark
    end
    @note_moyenne /= @paintings.size
  end

  private
  # Method to safely collect data from the user's parameters form and store them in the database
  def parameters_params
    params.require(:parameter).permit(:nbRectBlack, :nbRectWhite, :progressif)
  end
end
