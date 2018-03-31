class RemoveMarkToPainting < ActiveRecord::Migration
  def change
    remove_column :paintings, :mark
  end
end
