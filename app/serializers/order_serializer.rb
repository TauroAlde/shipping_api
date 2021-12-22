class OrderSerializer < ActiveModel::Serializer
  attributes :id, :reference, :import_detail_id

  has_many :import_detail
  has_many :shipments
end