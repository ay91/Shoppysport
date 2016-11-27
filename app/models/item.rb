class Item < ApplicationRecord
  paginates_per 10
  belongs_to :category
  has_many :ordered_items
  has_many :orders, through: :ordered_items
  mount_uploader :image, ImageUploader
  searchkick
end
