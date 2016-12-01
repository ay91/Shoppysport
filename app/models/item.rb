class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  paginates_per 12
  belongs_to :category
  has_many :ordered_items
  has_many :orders, through: :ordered_items
  mount_uploader :image, ImageUploader
  searchkick
end
