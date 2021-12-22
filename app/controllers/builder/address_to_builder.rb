class Builder::AddressToBuilder

  def self.call(address_to, headers)
    Address.create(
      name: address_to[headers[8]],
      email: address_to[headers[9]],
      street1: address_to[headers[10]],
      city: address_to[headers[11]],
      province: address_to[headers[12]],
      postal_code: address_to[headers[13]].to_i,
      contry_code: address_to[headers[14]]
    )
  end
end
