require 'rails_helper'

RSpec.describe Shipment, type: :model do
  context "relationships" do
    it { is_expected.to belong_to(:order).optional }
    it { is_expected.to belong_to(:address_from) }
    it { is_expected.to belong_to(:address_to) }
    it { is_expected.to have_many(:parcels) }
  end
end
