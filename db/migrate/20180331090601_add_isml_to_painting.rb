class AddIsmlToPainting < ActiveRecord::Migration
  def change
    add_column :paintings, :is_ml, :boolean, null: false, default: false
  end
end
