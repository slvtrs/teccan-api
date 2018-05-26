class AddTimestampsToDevices < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :devices, null: true
  end
end
