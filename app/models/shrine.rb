class Shrine < ApplicationRecord
  belongs_to :user
  has_many :offerings

  has_many :active_offerings,   -> { active },   class_name: "Offering"
  has_many :inactive_offerings, -> { inactive }, class_name: "Offering"

  has_many :inactive_items, through: :inactive_offerings,
                             class_name: "Item",
                             source: :item
  has_many :active_items,   through: :active_offerings,
                             class_name: "Item",
                             source: :item

  def self.mutate(shrines, current_user, location)
    json = []
    shrines.each do |shrine|
      shrine_loc = [shrine.latitude.to_f, shrine.longitude.to_f]
      dis = Distance.meters(location, shrine_loc)
      json << {
        id: shrine.id,
        created_at: shrine.created_at,
        updated_at: shrine.updated_at,
        title: shrine.title,
        description: shrine.description,
        latitude: shrine.latitude,
        longitude: shrine.longitude,
        user: shrine.user,
        is_mine: current_user.id == shrine.user_id,
        distance: dis,
      }
    end
    json
  end

  def self.nearest(shrines)
    nearest_shrine = nil
    distance_to_nearest_shrine = 6371000
    shrines.each do |shrine|
      if shrine[:distance] < distance_to_nearest_shrine
        nearest_shrine = shrine
      end
    end
    nearest_shrine
  end

  def get_location_string
    string = ""
    loc = Geocoder.search("#{self.latitude},#{self.longitude}").first
    if loc
      string = "#{loc.city}, #{loc.state_code}"
    end
    string
  end
end
