# require 'libsvm'

class PaintingsController < ApplicationController
  include UsersHelper
  include PaintingsHelper

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
    @painting.users_id = session_user_id
    if tableaux_notes >= tableaux_mini
      @painting.is_ml = true
    end
    if @painting.save
      redirect_to painting_path(@painting.id)
    else
      render :new
    end
  end

  def index
    @painting_id = id_tableaux_notes[params[:id].to_i-1]
    @painting = Painting.find(@painting_id)
    @JsonData = @painting.JsonData
    @hash = JSON.parse @JsonData
    @RectBlack = @hash['RectBlack']
    @RectWhite = @hash['RectWhite']
    @nbBlacks = @RectBlack.size
    @nbWhites = @RectWhite.size
  end

  def show
    @painting = Painting.find(params[:id])
    @JsonData = @painting.JsonData
    @hash = JSON.parse @JsonData
    @RectBlack = @hash['RectBlack']
    @RectWhite = @hash['RectWhite']
    @nbBlacks = @RectBlack.size
    @nbWhites = @RectWhite.size
    if tableaux_notes >= tableaux_mini
      @pred = liblinear_svm(@painting)
      if @pred > 2
        render :show
      else
        redirect_to '/generate'
      end
    end
  end

  private
  # Method to safely collect data from the user's parameters form and store them in the database
  def painting_params
    params.require(:painting).permit(:mark, :JsonData)
  end

  #
  # def test
  #   data = Painting.all
  #   # This library is namespaced.
  #   problem = Libsvm::Problem.new
  #   parameter = Libsvm::SvmParameter.new
  #   parameter.cache_size = 1 # in megabytes
  #
  #   parameter.eps = 0.001
  #   parameter.c = 10
  #
  #   examples = [ [1,6,2], [-1,0,-1] ].map {|ary| Libsvm::Node.features(ary) }
  #   labels = [1, -1]
  #
  #   problem.set_examples(labels, examples)
  #
  #   model = Libsvm::Model.train(problem, parameter)
  #   @pred = model.predict(Libsvm::Node.features(1, 1, 1))
  #   return @pred
  # end
end
