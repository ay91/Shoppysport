class Order < ApplicationRecord
  belongs_to :user
  has_many :ordered_items, dependent: :destroy
  has_many :items, through: :ordered_items

  enum status: [:pending, :processed, :shipped]
end
