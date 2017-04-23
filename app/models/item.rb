class Item < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :order_items
  has_many :reviews


  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: -1 }
  validates :name, presence: true, uniqueness: true


  def average_rating
    total = 0
    num_of_ratings = 0
    self.reviews.each do |review|
      if review.rating != nil
        total += review.rating
        num_of_ratings += 1
      end
    end
    if num_of_ratings > 0
      return (total/num_of_ratings.to_f).round(1)
    else
      return "no rating yet"
    end
  end


end
