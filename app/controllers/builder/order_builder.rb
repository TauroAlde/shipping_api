class Builder::OrderBuilder

  def self.call(record, header, import_detail)
    Order.create(
      reference: record[header[0]],
      import_detail_id: import_detail.id
    )
  end
end