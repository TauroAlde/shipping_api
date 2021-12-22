require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

RSpec.describe Services::JsonWebToken, type: :model do
  let!(:user) { create(:user, password: "12345", password_confirmation: "12345")}
  let(:exp) { 6.hours.from_now.to_i }

  context "#encode" do

    it "has no errors" do
      expect { Services::JsonWebToken.encode(user, exp) }.not_to raise_error
    end

    it "has bad user" do
      expect { Services::JsonWebToken.encode("different_property", exp) }.to raise_error(NoMethodError)
    end

  end
  
  context "#decode" do

    subject! { described_class.encode(user, exp) }

    it "has a expired token" do
      travel 12.hours do
        expect { Services::JsonWebToken.decode(subject) }.to raise_error(JWT::ExpiredSignature)
      end
    end

    it "has a user" do
      decoded = JWT.decode subject, ENV["PRIVATE_SECRET_KEY"], true, { algorithm: 'HS256' }
      user = User.find(decoded[0]["sub"])
      expect(user).to match(user)
    end

    it "has a fake token" do
      expect { JWT.decode(Faker::Internet.device_token) }.to raise_error(JWT::DecodeError)
    end
  end
end
