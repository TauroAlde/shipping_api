require 'rails_helper'

RSpec.describe Address, type: :model do
  context "with valid attributes" do
    it 'returns a address saved' do
      address = build(:address)
      address.valid?
      expect(address).to be_truthy
    end
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:street1) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_presence_of(:contry_code) }
  end

  context "with not valid attirbutes" do
    it "retrns name error" do
      address = Address.new
      address.name = "%"
      expect(address).not_to allow_value('%').for(:name)
    end

    it "return a email error" do
      address = build(:address, email: "example.com")
      address.valid?
      expect(address.errors.full_messages).to match(["Email is invalid"])
    end

    it "return a streer1 error with this characters %$&@+|" do
      address1 = build(:address, street1: "%chetumal")
      address2 = build(:address, street1: "$chetumal")
      address3 = build(:address, street1: "&chetumal")
      address4 = build(:address, street1: "@chetumal")
      address5 = build(:address, street1: "+chetumal")
      address6 = build(:address, street1: "|chetumal")
      address1.valid?
      address2.valid?
      address3.valid?
      address4.valid?
      address5.valid?
      address6.valid?
      expect(address1.errors.full_messages).to match(["Street1 is invalid"])
      expect(address2.errors.full_messages).to match(["Street1 is invalid"])
      expect(address3.errors.full_messages).to match(["Street1 is invalid"])
      expect(address4.errors.full_messages).to match(["Street1 is invalid"])
      expect(address5.errors.full_messages).to match(["Street1 is invalid"])
      expect(address6.errors.full_messages).to match(["Street1 is invalid"])
    end
  end
end
