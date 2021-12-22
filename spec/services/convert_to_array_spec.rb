require 'rails_helper'

RSpec.describe Services::ConvertToArray, type: :model do
  let(:file) {
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/shipments_data_correct.csv')))
  }
  let(:read) { File.read(file) }
  context "return a hash" do
    it "description" do
      expect(Services::ConvertToArray.call(read).class).to eql(Array)
    end
  end
end