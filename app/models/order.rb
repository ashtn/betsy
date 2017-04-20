class Order < ApplicationRecord
  has_and_belongs_to_many :items

  validates :status, presence: true
end
