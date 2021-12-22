class AddressSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :street1, :city, :province, :postal_code, :contry_code
end