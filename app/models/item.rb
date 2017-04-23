class Item < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
<<<<<<< HEAD
  has_many :reviews
=======

  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, uniqueness: true

>>>>>>> 50fd57b32aaa5b056e8e3b6db165e10629f48c22
end
