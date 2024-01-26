class Campaign < ApplicationRecord
  has_and_belongs_to_many :emails
  has_and_belongs_to_many :customers
end
