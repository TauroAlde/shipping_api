require 'rails_helper'

RSpec.describe Api::V1::ImportDetailsController, type: :request do
  context "GET /index" do
    let(:user) { create(:user, password: "12345", password_confirmation: "12345") }
    let(:token) { Services::JsonWebToken.encode(user) }
    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

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

      let(:params) {{id: uuid}}
      let(:importer_worker) { Workers::ImporterWorker.perform_async(uuid) }
      it "returns a job in queue" do
        Sidekiq::Testing.fake! do
          expect {
            importer_worker
          }.to change(Workers::ImporterWorker.jobs, :size).by(1)
        end
      end

      it "returns a completed status" do
        Sidekiq::Testing.inline! do
          expect {
            importer_worker
          }.to change { import_detail.reload.status }.to(ImportDetail::COMPLETED)
        end
      end

      it "description" do
        Sidekiq::Testing.inline! do
          importer_worker
          post "/api/v1/import_details", params: params, headers: headers
          expect(response.body).to match("completed")
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
      it "returns a error status" do
        Sidekiq::Testing.inline! do
          expect {
            importer_worker
          }.to change { import_detail.reload.status }.to(ImportDetail::ERROR)
        end
      end
    end
    
  end
end
