class CreatePossessions < ActiveRecord::Migration[5.1]
  def change
    create_table :possessions do |t|
      t.boolean :active
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.string :longitude
      t.string :latitude
      t.string :message
    end
  end
end
