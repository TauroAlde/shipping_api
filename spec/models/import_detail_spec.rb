require 'rails_helper'

RSpec.describe ImportDetail, type: :model do
  context "with validates atributtes" do
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_presence_of(:headers) }
    it { is_expected.to validate_presence_of(:data) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
