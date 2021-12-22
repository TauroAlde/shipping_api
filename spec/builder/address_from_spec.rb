require 'rails_helper'

RSpec.describe Builder::AddressFromBuilder, type: :model do
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
        }
      end

      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }

      it "returns a builder" do
        expect { Builder::AddressFromBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers)) }
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
        }
      end

      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }

      it "returns a error" do
        expect(
          Builder::AddressFromBuilder.call(
            JSON.parse(import_detail.data),
            JSON.parse(import_detail.headers)
          ).errors.full_messages
        )
        .to match(["Postal code is the wrong length (should be 5 characters)"])
      end
    end
  end
end
