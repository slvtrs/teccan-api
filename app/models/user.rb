class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :devices, dependent: :destroy
  has_many :possessions, dependent: :destroy

  has_many :active_possessions,   -> { active },   class_name: "Possession"
  has_many :inactive_possessions, -> { inactive }, class_name: "Possession"

  has_many :inactive_items, through: :inactive_possessions,
                             class_name: "Item",
                             source: :item
  has_many :active_items,   through: :active_possessions,
                             class_name: "Item",
                             source: :item

  def create_initial_inventory
    items = Item.get_all_unpossessed
    items.first(3).each do |item|
      possession = self.possessions.build(item_id: item.id)
      possession.save
    end
  end

  def init_device
    device = self.devices.build
    device.save
    token = device.token
    auth_token = "#{self.id}:#{token}"
  end

end
