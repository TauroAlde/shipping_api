require 'rails_helper'

RSpec.describe Api::V1::LoginController, type: :request do
  context "GET /index" do
    context "when is successful" do
      let(:user) { create(:user, password: "12345", password_confirmation: "12345") }
  
      let(:params) do 
        {
          login: {
            username: user.username,
            password: user.password
          }
        }
      end
      it "returns a user token", :show_in_doc do
        post "/api/v1/login", params: params
        expect(response).to have_http_status(:ok)
      end
    end
    context "when is not successful" do
      let(:user) { create(:user, password: "12345", password_confirmation: "12345") }
  
      let(:params) do 
        {
          login: {
            username: "juan",
            password: "654321"
          }
        }
      end
      it "returns a unauthorized" do
        post "/api/v1/login", params: params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  
end
