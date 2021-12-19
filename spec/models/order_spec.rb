require 'rails_helper'

RSpec.describe Order, type: :model do
  context "with valid attributes" do
    it { is_expected.to validate_presence_of(:reference) }
  end

  context "relationship" do
    it { is_expected.to have_many(:shipments) }
  end
end
