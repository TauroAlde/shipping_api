require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe Workers::ImporterWorker, type: :worker do
  context "#call" do
    
    context "when is successful" do
      let(:file) {
        Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/shipments_data_correct.csv')))
      }
      let(:read) { File.read(file) }
      let(:records) { Services::ConvertToArray.call(read) }
      let(:uuid) { SecureRandom.uuid }
      let!(:import_detail) {
        create(:import_detail,
          uuid: uuid,
          headers: records.first.keys.to_json,
          data: records.to_json,
          status: ImportDetail::PENDING,
        )
      }
  
      let(:importer_worker) { Workers::ImporterWorker.perform_async(uuid) }

      Sidekiq::Testing.inline! do
        it "returns a Order created" do
          expect { importer_worker }.to change { Order.count }.by(1)
        end
        it "returns a Address created" do
          expect { importer_worker }.to change { Address.count }.by(2)
        end
        it "returns a Shipment created" do
          expect { importer_worker }.to change { Shipment.count }.by(1)
        end
        it "returns a Parcel created" do
          expect { importer_worker }.to change { Parcel.count }.by(1)
        end
        it "returns a imported completed" do
          expect { importer_worker }.to change { import_detail.reload.status }.to(ImportDetail::COMPLETED)
        end
      end
    end

    context "when is not successful" do
      let(:file) {
        Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/shipments_data.csv')))
      }
      let(:read) { File.read(file) }
      let(:records) { Services::ConvertToArray.call(read) }
      let(:uuid) { SecureRandom.uuid }
      let!(:import_detail) {
        create(:import_detail,
          uuid: uuid,
          headers: records.first.keys.to_json,
          data: records.to_json,
          status: ImportDetail::PENDING,
        )
      }
  
      let(:importer_worker) { Workers::ImporterWorker.perform_async(uuid) }

      Sidekiq::Testing.inline! do
        it "returns status error" do
          expect { importer_worker}.to change { import_detail.reload.status }.to(ImportDetail::ERROR)
        end
        it "returns import_detail errors" do
          expect { importer_worker}.to change { import_detail.reload.error }
        end
      end
    end
  end
end