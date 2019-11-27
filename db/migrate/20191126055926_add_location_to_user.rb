class AddLocationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :longitude, :decimal
    add_column :users, :latitude, :decimal
  end
end
