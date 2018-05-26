class AddLocationToPossesions < ActiveRecord::Migration[5.1]
  def change
    add_column :possessions, :longitude_1, :string
    add_column :possessions, :longitude_2, :string
    add_column :possessions, :latitude_1, :string
    add_column :possessions, :latitude_2, :string

    remove_column :possessions, :latitude
    remove_column :possessions, :longitude
  end
end
