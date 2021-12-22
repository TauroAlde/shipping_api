class Builder::ParcelBuilder

  def self.call(parcel, shipment, headers)
    Parcel.create(
      lenght: parcel[headers[15]].to_i,
      width: parcel[headers[16]].to_i,
      height: parcel[headers[17]].to_i,
      dimension_unit: parcel[headers[18]],
      weight: parcel[headers[19]].to_i,
      weight_unit: parcel[headers[20]],
      shipment_id: shipment.id
    )
  end
end
