require 'rails_helper'

RSpec.describe Parcel, type: :model do
  context "with valid attributes" do
    it { is_expected.to validate_numericality_of(:lenght) }
    it { is_expected.to validate_presence_of(:lenght) }
    it { is_expected.to validate_numericality_of(:lenght).only_integer }

    it { is_expected.to validate_numericality_of(:width) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_numericality_of(:width).only_integer }

    it { is_expected.to validate_numericality_of(:height) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_numericality_of(:height).only_integer }
  
    it { is_expected.to validate_numericality_of(:weight) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight).only_integer }

    it { is_expected.to validate_length_of(:dimension_unit).is_equal_to(2) }
    it { is_expected.to allow_value('Cm').for(:dimension_unit) }
    it { is_expected.to validate_length_of(:weight_unit).is_equal_to(2) }
    it { is_expected.to allow_value('Kg').for(:weight_unit) }
  end

  context "relationships to shipment" do
    it { is_expected.to belong_to(:shipment) }
  end
  context "with not valid attributes" do

    it { is_expected.to_not validate_length_of(:dimension_unit).is_equal_to(1) }
    it { is_expected.to_not allow_value('string').for(:dimension_unit) }

    it { is_expected.to_not validate_length_of(:weight_unit).is_equal_to(12) }
    it { is_expected.to_not allow_value('k').for(:weight_unit) }
  end
end
