class Item < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items

  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, uniqueness: true

end
