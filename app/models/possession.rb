class Possession < ApplicationRecord
  has_one :item
  belongs_to :user
end

# rails g migration CreatePossessions active:boolean user:references item:references
