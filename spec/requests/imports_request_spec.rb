require 'rails_helper'

RSpec.describe Api::V1::ImportsController, type: :request do
  let(:user) { create(:user, password: "12345", password_confirmation: "12345", email: "example@exam.com") }
  let(:token) { Services::JsonWebToken.encode(user) }
  let(:headers) do
    {
      "Authorization" => "Bearer #{token}"
    }
  end

  context "POST / Imports" do
    context "when is successful" do
      let(:params) {
        { 
          shipments_data: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/shipments_data.csv')))
        }
      }

      it "returns a imports" do
        post "/api/v1/imports", params: params ,headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context "when is not successful" do
      let(:params) {
        { 
          shipments_data: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/example.txt')))
        }
      }

      it "returns a format no supported" do
        post "/api/v1/imports", params: params ,headers: headers
        expect(response.body).to match("Format not supported")
      end
    end
  end
end
