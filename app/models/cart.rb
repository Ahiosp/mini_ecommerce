class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :product, through: cart_item
end
