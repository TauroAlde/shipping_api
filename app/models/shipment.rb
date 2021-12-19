class Shipment < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :address_from, class_name: "Address", foreign_key: "address_from_id"
  belongs_to :address_to, class_name: "Address", foreign_key: "address_to_id"
  has_many :parcels
end
