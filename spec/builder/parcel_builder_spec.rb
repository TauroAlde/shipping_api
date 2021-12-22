require 'rails_helper'

RSpec.describe Builder::ParcelBuilder, type: :model do
  context "#call" do

    context "when is successful" do
      let(:record) do
        {
          "order_reference"=>"OR00001",
          "address_from_name"=>"Fernando López",
          "address_from_email"=>"fernando@example.com",
          "address_from_street1"=>"Av. Principal #123",
          "address_from_city"=>"Azcapotzalco",
          "address_from_province"=>"Ciudad de México",
          "address_from_postal_code"=>"2900",
          "address_from_country_code"=>"MX",
          "address_to_name"=>"Isabel Arredondo",
          "address_to_email"=>"isabel@example.com",
          "address_to_street1"=>"Av. las torres #123",
          "address_to_city"=>"Puebla",
          "address_to_province"=>"Puebla",
          "address_to_postal_code"=>"72450",
          "address_to_country_code"=>"MX",
          "parcel_length"=>"40",
          "parcel_width"=>"40",
          "parcel_height"=>"40",
          "parcel_dimensions_unit"=>"CM",
          "parcel_weight"=>"5",
          "parcel_weight_unit"=>"KG"
        }
      end

      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }
      let(:order) { Builder::OrderBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers), import_detail) }
      let(:address_from) {
        Builder::AddressFromBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers))
      }
      let(:address_to) {
        Builder::AddressToBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers))
      }
      let(:shipment) { 
        Builder::ShipmentBuilder.call( order, address_from, address_to )
       }

      it "returns a builder" do
        expect { Builder::ParcelBuilder.call( record, shipment, import_detail.headers ) }
        .to change { Address.count }.from(0).to(1)
      end
    end

    context "when is not successful" do
      let(:record) do
        {
          "order_reference"=>"OR00001",
          "address_from_name"=>"Fernando López",
          "address_from_email"=>"fernando@example.com",
          "address_from_street1"=>"Av. Principal #123",
          "address_from_city"=>"Azcapotzalco",
          "address_from_province"=>"Ciudad de México",
          "address_from_postal_code"=>"2900",
          "address_from_country_code"=>"MX",
          "address_to_name"=>"Isabel Arredondo",
          "address_to_email"=>"isabel@example.com",
          "address_to_street1"=>"Av. las torres #123",
          "address_to_city"=>"Puebla",
          "address_to_province"=>"Puebla",
          "address_to_postal_code"=>"72450",
          "address_to_country_code"=>"MEX",
          "parcel_length"=>"40",
          "parcel_width"=>"40",
          "parcel_height"=>"40",
          "parcel_dimensions_unit"=>"CM",
          "parcel_weight"=>"5",
          "parcel_weight_unit"=>"KG"
        }
      end

      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }
      let(:order) { Builder::OrderBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers), import_detail) }
      let(:address_from) {
        Builder::AddressFromBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers))
      }
      let(:address_to) {
        Builder::AddressToBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers))
      }
      let(:shipment) { Builder::ShipmentBuilder.call( order, address_from, address_to ) }

      it "returns a errors" do
        expect( Builder::ParcelBuilder.call( record, shipment, import_detail.headers ).errors.full_messages )
        .to match(
          [
            "Dimension unit is the wrong length (should be 2 characters)",
            "Weight unit is the wrong length (should be 2 characters)",
            "Dimension unit is invalid",
            "Weight unit is invalid",
            "Shipment must exist"
          ]
        )
      end
    end
  end
end



