class Services::ConvertToArray
  require 'csv'

  def self.call(csv_text)
    csv = CSV.parse(csv_text, :headers => true)

    records = []
    csv.each do |row|
      records << row.to_h
    end
    return records
  end
end