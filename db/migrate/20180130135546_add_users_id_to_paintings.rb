class AddUsersIdToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :users_id, :integer
  end
end
