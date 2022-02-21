class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

   enum making_status:{before: 0, wait: 1, make: 2, finish: 3}
   validates :amount, presence: true
   validates :price, presence: true
end
