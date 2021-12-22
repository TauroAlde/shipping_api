class Order < ApplicationRecord

  VALID_REFERENCE_REGEX = /\A[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ]+\z/

  validates :reference, format: { with: VALID_REFERENCE_REGEX }, length: { maximum: 32 }, presence: true

  belongs_to :import_detail
  has_many :shipments

end
