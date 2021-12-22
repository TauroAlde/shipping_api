class ParcelSerializer < ActiveModel::Serializer
  attributes :id, :lenght, :width, :height, :dimension_unit, :weight_unit, :weight

  belongs_to :shipment
end
