class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :devices, dependent: :destroy
  # has_many :possessions, dependent: :destroy
  # has_many :items, through: :possessions
  # has_many :items, -> { where(active: true) }, class_name: "Item", 
  #   through: :possessions, source: :item

  def init_device
    device = self.devices.build
    device.save
    token = device.token
    auth_token = "#{self.id}:#{token}"
  end

end
