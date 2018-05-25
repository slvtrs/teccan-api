class Item < ApplicationRecord

  def self.get_all_unpossessed
    # possessed_item_ids = Possession.where(active: true).pluck(:item_id)
    # items = Item.where.not(id: possessed_item_ids)
    Item.create_initial_items
  end

  def self.create_initial_items
    items = [
      {
        title: 'Gem of Ruby', 
        description: "A powerful tool, a valuable crystal, and a tasty treat.", 
        longitude: -123.0, 
        latitude: 40,
      },
      {
        title: 'Cursive Java Quill',
        description: "Gravity doesn't grant me the privilege of failure.", 
        longitude: -121.0, 
        latitude: 38,
      },
      {
        title: 'Python Egg', 
        description: "Great potential lies within.", 
        longitude: -122.0, 
        latitude: 39,
      },
      {
        title: 'Shadow of Dom', 
        description: "Much like the Dom, except flightier.", 
        longitude: -122.0, 
        latitude: 40,
      },
      {
        title: 'Native Hieroglyph', 
        description: "From ancient times before compilers.", 
        longitude: -122.5, 
        latitude: 38,
      },
      {
        title: 'Raven Cache', 
        description: "What once was shall never be nevermore.",
        longitude: -120.0, 
        latitude: 41,
      },
      {
        title: 'Ruined Artifact', 
        description: "A trace of something vaguely interesting remains beneath the decay.",
        longitude: -121.0, 
        latitude: 41.5,
      },
    ]
  end
end
