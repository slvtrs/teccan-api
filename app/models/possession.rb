class Possession < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates_associated :item
  # validates :latitude, :longitude, presence: true
  
  scope :active,   -> { where(active: true)  }
  scope :inactive, -> { where(active: false) }
end
