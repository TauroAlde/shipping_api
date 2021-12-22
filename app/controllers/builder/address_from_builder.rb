class Builder::AddressFromBuilder

  def self.call(address_from, headers)
    Address.create(
      name: address_from[headers[1]],
      email: address_from[headers[2]],
      street1: address_from[headers[3]],
      city: address_from[headers[4]],
      province: address_from[headers[5]],
      postal_code: address_from[headers[6]].to_i,
      contry_code: address_from[headers[7]]
    )
  end
end
