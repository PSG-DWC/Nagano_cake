class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :orders
        has_many :addresses
        has_many :cart_items

        validates :last_name, presence: true, format:{ with:  /\A[一-龥]+\z/}
        validates :first_name, presence: true, format:{ with:  /\A[一-龥]+\z/}
        validates :last_name_kana, presence: true,format:{ with:  /\A[ァ-ヶー－]+\z/}
        validates :first_name_kane, presence: true,format:{ with:  /\A[ァ-ヶー－]+\z/}
        validates :post_code, presence: true, format:{ with:  /\A\d{7}\z/}
        validates :address, presence:true
        validates :phone_namber, presence: true,format:{ with:  /\A\d{10,11}\z/}
end
