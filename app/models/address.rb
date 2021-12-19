class Address < ApplicationRecord

  before_save  :downcase_email

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z]+[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_STREET1_REGEX = /\A([^%$&@+|]|[-])*\Z/
  VALID_NAME_REGEX = /\A[a-zA-Z0-9 ]+\z/
  VALID_CITY_REGEX = /\A[a-zA-Z ]+\z/
  VALID_PROVINCE_REGEX = /\A[a-zA-Z ]+\z/

  validates :name, format: { with: VALID_NAME_REGEX }, length: { maximum: 64 }
  validates :email, presence: true, length: { maximum: 128 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :street1, presence: true, format: { with: VALID_STREET1_REGEX }
  validates :city, length: { maximum: 64 }, format: { with: VALID_CITY_REGEX }
  validates :province, length: { maximum: 64 }, format: { with: VALID_PROVINCE_REGEX }
  validates :postal_code, length: { is: 5 }, presence: true
  validates :contry_code, length: { is: 2 }, presence: true

  has_many :shipments_from, class_name: "Shipment", foreign_key: "address_from_id"
  has_many :shipments_to, class_name: "Shipment", foreign_key: "address_to_id"

  private

  def downcase_email
    self.email.downcase!
  end
end
