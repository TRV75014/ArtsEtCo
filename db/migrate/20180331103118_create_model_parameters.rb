class CreateModelParameters < ActiveRecord::Migration
  def change
    create_table :model_parameters do |t|
      t.string :nom_modele
      t.integer :tableaux_mini
      t.belongs_to :users
      
      t.timestamps null: false
    end
  end
end
