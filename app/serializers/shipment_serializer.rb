class UserSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :address_from_id, :address_to_id

  belongs_to :order
  belongs_to :address_from
  belongs_to :address_to
  has_many :parcels
end
