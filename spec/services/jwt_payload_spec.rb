require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

RSpec.describe Services::JwtPayload, type: :model do
  let(:user) { create(:user, password: "12345", password_confirmation: "12345") }
  let(:exp) {24.hours.from_now.to_i}
  let(:jwt_payload) { Services::JwtPayload.new(user, exp: exp) }
  context "when is successful" do
    it "return a payload data" do
      expect(jwt_payload.data).not_to be_nil
    end
  end
end