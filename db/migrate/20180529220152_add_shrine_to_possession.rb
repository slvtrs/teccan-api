class AddShrineToPossession < ActiveRecord::Migration[5.1]
  def change
    add_reference :possessions, :shrine, foreign_key: true
  end
end
