class CreateNoteMls < ActiveRecord::Migration
  def change
    create_table :note_mls do |t|
      t.integer :note_algo
      t.belongs_to :paintings

      t.timestamps null: false
    end
  end
end
