class CreateOfferings < ActiveRecord::Migration[5.1]
  def change
    create_table :offerings do |t|
      t.boolean :active, default: true
      t.references :shrine, foreign_key: true
      t.references :item, foreign_key: true
      t.references :possession, foreign_key: true
      t.string :message
      t.timestamps
    end
  end
end
