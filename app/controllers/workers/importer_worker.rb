class Workers::ImporterWorker
  include Sidekiq::Worker

  def perform(uuid)
    import_detail = ImportDetail.find_by(uuid: uuid)
    errors = []
    headers = JSON.parse(import_detail.headers)
    import_detail.update(status: ImportDetail::PROCESSING)
    JSON.parse(import_detail.data).each_with_index do |record, index|
      ActiveRecord::Base.transaction do
        order = Builder::OrderBuilder.call(record, headers, import_detail)
        address_from = Builder::AddressFromBuilder.call(record, headers)
        address_to = Builder::AddressToBuilder.call(record, headers)
        shipment = Builder::ShipmentBuilder.call(order, address_from, address_to)
        parcel = Builder::ParcelBuilder.call(record, shipment, headers)

        if order.errors.present? || address_to.errors.present? || address_from.errors.present? || parcel.errors.present?
          raise ActiveRecord::RecordInvalid
        end
      rescue ActiveRecord::RecordInvalid
        errors << build_errors( index, order, address_from, address_to, shipment, parcel)
        raise ActiveRecord::Rollback
      end
    end

    if errors.present?
      import_detail.update(
        error: errors.to_json,
        status: ImportDetail::ERROR
      )
    else
      import_detail.update(
        status: ImportDetail::COMPLETED
      )
    end
  end

  def build_errors(index, order, address_from, address_to, shipment, parcel)
    {
      'row' => index,
      'order' => order.errors.full_messages,
      'address_from' => address_from.errors.full_messages,
      'address_to' => address_to.errors.full_messages,
      'shipment' => shipment.errors.full_messages,
      'parcel' => parcel.errors.full_messages
    }
  end
end
