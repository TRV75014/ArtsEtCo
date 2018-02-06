require 'libsvm'

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
    # @pred = test
    # note moyenne
    @paintings = Painting.where(users_id: session[:user_id])
    @note_moyenne = 0.0
    @paintings.each do |p|
      @note_moyenne = @note_moyenne+ p.mark
    end
    @note_moyenne /= @paintings.size
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
