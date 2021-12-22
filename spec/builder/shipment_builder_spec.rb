require 'rails_helper'

RSpec.describe Builder::ShipmentBuilder, type: :model do
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
          "address_from_postal_code"=>"22900",
          "address_from_country_code"=>"MX",
          "address_to_name"=>"Isabel Arredondo",
          "address_to_email"=>"isabel@example.com",
          "address_to_street1"=>"Av. las torres #123",
          "address_to_city"=>"Puebla",
          "address_to_province"=>"Puebla",
          "address_to_postal_code"=>"72450",
          "address_to_country_code"=>"MX"
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
      it "returns a builder" do
        expect { 
          Builder::ShipmentBuilder.call(
            order,
            address_from,
            address_to
          )
        }.to change { Shipment.count }.from(0).to(1)
      end
    end

    context "when is not successful" do
      let(:record) do
        {
          "order_reference"=>"OR0#001",
          "address_from_name"=>"Fernando López",
          "address_from_email"=>"fernando@example.com",
          "address_from_street1"=>"Av. Principal #123",
          "address_from_city"=>"Azcapotzalco",
          "address_from_province"=>"Ciudad de México",
          "address_from_postal_code"=>"2200",
          "address_from_country_code"=>"MX",
          "address_to_name"=>"Isabel Arredondo",
          "address_to_email"=>"isabel@example.com",
          "address_to_street1"=>"Av. las torres #123",
          "address_to_city"=>"Puebla",
          "address_to_province"=>"Puebla",
          "address_to_postal_code"=>"72450",
          "address_to_country_code"=>"MEX"
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
  
      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }
      it "returns a error" do
        expect(
          Builder::ShipmentBuilder.call(
            order,
            address_from,
            address_to
          ).errors.full_messages
        )
        .to match(["Address from must exist", "Address to must exist"])
      end
    end
  end
end
