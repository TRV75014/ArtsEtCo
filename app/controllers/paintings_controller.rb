class PaintingsController < ApplicationController
  attr_accessor :users_id

  # new action
  def new
    @painting = Painting.new
    @nbParameters = Parameter.all.count
    @parameter = Parameter.find(@nbParameters)
    @nbRectBlack = @parameter.nbRectBlack
    @nbRectWhite = @parameter.nbRectWhite
    @progressif = @parameter.progressif
  end

  # home action
  def create
    @painting = Painting.new(painting_params)
    @painting.users_id = session[:user_id]
    if @painting.save
      redirect_to '/generate'
    else
      render 'generate'
    end
  end

  def index
    @paintings = Painting.where(users_id: session[:user_id]).limit(params[:id])
    @painting = @paintings.last
    @mark = @painting.mark
    @JsonData = @painting.JsonData
    @hash = JSON.parse @JsonData
    @RectBlack = @hash['RectBlack']
    @RectWhite = @hash['RectWhite']
    @nbBlacks = @RectBlack.size
    @nbWhites = @RectWhite.size
  end

  private
  # Method to safely collect data from the user's parameters form and store them in the database
  def painting_params
    params.require(:painting).permit(:mark, :JsonData, session[:user_id])
  end
end
