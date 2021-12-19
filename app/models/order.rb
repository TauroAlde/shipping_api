class Order < ApplicationRecord
  validates :reference, presence: true

  has_many :shipments
end
