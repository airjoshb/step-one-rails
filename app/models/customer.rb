class Customer < ApplicationRecord
  has_many :customer_orders
  has_many :addresses, through: :customer_orders
  has_many :payment_methods, through: :customer_orders
  has_many :orderables, through: :customer_orders

  validates :email, presence: true
  validates_uniqueness_of :email
  
  has_subscriptions


end
