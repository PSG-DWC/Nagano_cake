class Item < ApplicationRecord
  attachment :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_details

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true
  validates :introduction, presence: true
end
