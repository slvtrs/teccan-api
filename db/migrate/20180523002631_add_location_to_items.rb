class AddLocationToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :longitude, :string
    add_column :items, :latitude, :string
  end
end
