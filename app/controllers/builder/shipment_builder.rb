class Builder::ShipmentBuilder

  def self.call(order, address_from, address_to)
    Shipment.create(
      order_id: order.id,
      address_from_id: address_from.id,
      address_to_id: address_to.id
    )
  end
end
