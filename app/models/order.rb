class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  enum status: { waiting_deposit: 0, payment_confirmation: 1, in_production: 2, preparing_ship: 3, shipped_items: 4 }
  validates :name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true, format:{ with:  /\A\d{7}\z/}
  validates :total_payment, presence: true


end
