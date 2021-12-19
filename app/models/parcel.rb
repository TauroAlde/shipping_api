class Parcel < ApplicationRecord

  VALID_DIMENSION_AND_WEIGHT_UNIT_REGEX = /\A[a-zA-Z]+\z/

  validates :lenght, presence: true, numericality: { only_integer: true }
  validates :width, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true }
  validates :dimension_unit, :weight_unit, length: { is: 2 }, format: { with: VALID_DIMENSION_AND_WEIGHT_UNIT_REGEX }
  validates :weight, presence: true, numericality: { only_integer: true }

  belongs_to :shipment
end
