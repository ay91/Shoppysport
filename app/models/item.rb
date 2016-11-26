class Item < ApplicationRecord

  belongs_to :category
  has_many :ordered_items
  has_many :orders, through: :ordered_items
  mount_uploader :image, ImageUploader
end
