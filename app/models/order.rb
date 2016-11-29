class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_items
  has_many :items, through: :ordered_items

  enum status: [:pending, :processed, :shipped] 
end
