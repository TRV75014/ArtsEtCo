require 'libsvm'
require 'liblinear'

module PaintingsHelper
  #Nombre de tableaux minimum pour activer l'algorithme
  def tableaux_mini
    ModelParameter.last.tableaux_mini
  end

  # Nom du modèle utilisé
  def nom_modele
    ModelParameter.last.nom_modele
  end

  def liblinear_svm(painting)
    # This library is namespaced.
    data = Painting.order(:created_at).where(users_id: session_user_id)
    examples = []
    labels = []
    data.each do |d|
      mark = d.mark
      unless mark.nil?
        example = []
        hash = JSON.parse d.JsonData
        rectBlack = hash['RectBlack']
        rectBlack.each do |r|
          r.each do |coord|
            example.push(coord)
          end
        end
        rectWhite = hash['RectWhite']
        rectWhite.each do |r|
          r.each do |coord|
            example.push(coord)
          end
        end
        examples.push(example)
        labels.push(mark)
      end
    end

    model = Liblinear.train(
      { solver_type: Liblinear::L2R_LR },
      labels,
      examples,
    )

    paintings_data = []
    @JsonData = @painting.JsonData
    @hash = JSON.parse @JsonData
    @RectBlack = @hash['RectBlack']
    @RectWhite = @hash['RectWhite']
    @RectBlack.each do |r|
      r.each do |coord|
        paintings_data.push(coord)
      end
    end
    @RectWhite.each do |r|
      r.each do |coord|
        paintings_data.push(coord)
      end
    end
    return Liblinear.predict(model, paintings_data)
  end
end
