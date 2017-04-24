class Merchant < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :items

  def self.create_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash["uid"]
    merchant.provider = auth_hash["provider"]
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]

    merchant.save ? nickname : nil

  end
end
