class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  validates :name, presence: true
  validates :address, presence: true
  validates :post_code, presence: true, format:{ with:  /\A\d{7}\z/}
  validates :total_payment, presence: true

end
