class AddTimestampsToPossessions < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :possessions, null: true
  end
end
