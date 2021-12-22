require 'rails_helper'

RSpec.describe Builder::OrderBuilder, type: :model do
  context "#call" do
    
    context "when is successful" do
      let(:record) do
        {
          "order_reference"=>"OR00001"
        }
      end
  
      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }
      it "returns a builder" do
        expect { Builder::OrderBuilder.call(JSON.parse(import_detail.data), JSON.parse(import_detail.headers), import_detail) }
        .to change { Order.count }.from(0).to(1)
      end
    end

    context "when is not successful" do
      let(:record) do
        {
          "order_reference"=> "%"
        }
      end
  
      let(:import_detail) { create(:import_detail, row: 1, data: record.to_json, headers: record.keys) }
      it "returns a error" do
        expect(
          Builder::OrderBuilder.call(
            JSON.parse(import_detail.data),
            JSON.parse(import_detail.headers),
            import_detail
          ).errors.full_messages
        )
        .to match(["Reference is invalid"])
      end
    end
  end
end
