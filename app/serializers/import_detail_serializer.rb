class ImportDetailSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :headers, :data, :status, :row, :error

  has_many :shipments_from
  has_many :shipments_to
end