class AddDefaultActiveToPossessions < ActiveRecord::Migration[5.1]
  def change
    change_column :possessions, :active, :boolean, default: true
  end
end
