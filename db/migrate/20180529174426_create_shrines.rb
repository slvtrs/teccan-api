class CreateShrines < ActiveRecord::Migration[5.1]
  def change
    create_table :shrines do |t|
      t.string :title
      t.string :description
      t.string :image
      t.string :latitude
      t.string :longitude
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
